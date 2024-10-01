##
# Meson Adapter Makefile
#
# An adapter for enabling Meson builds for targets that are not able to be
# supported by the Meson build system. Meson has a rigid structure to the format
# and order of arguments generated for linking that prevents the linking command
# for some code genereration tools from being being generated properly.
# TODO explain what this Makefile provides.

# Usage
#
# 1. Set OUTPUT_NAME to the P/N or desired executable name. 
# 2. Ensure the correct TI CGT version is being used.
# 3. Verify / adjust compiler flags: CL2000_FLAGS.
# 4. Verify / adjust linker flags: LINKER_FLAGS.
# 5. Set / unset preprocessor macros: DEFINES & UNDEFINES.
# 6. Set all sources, command files, and libraries:
#		CMD_SRCS: 		.cmd command files to be linked in.
# 		LIB_SRCS: 		.lib library files to be linked in.
# 		ASM_SRCS: 		.asm source files to be compiled in.
# 		C_SRCS:   		.c source files to be compiled in.
# 		LINKED_LIBS: 	libs that require an -l flag with the linker.
# 		INC_DIRS: 		include dirs; -I is automatically prepended.
# 7. Make desired adjustments to the additonal build targets for tasks / tools.
# 
# Environment Variables Required
# 
# TI_COMPILERS_DIR path to the dir that contains the root dir of TI CGT installs
# 

# Part number or executable name.
# 
OUTPUT_NAME ?= example-i2c-ti-f28379d-bme280

# Root of the project.
# 
PROJECT_HOME_DIR = $(CURDIR)

# TI Code Generation tools to use.
# 
CG_TOOLS_VER ?= 22.6.1.LTS
CG_TOOL_ROOT := $(TI_COMPILERS_DIR)/ti-cgt-c2000_$(CG_TOOLS_VER)

# Set delete commands.
# 
RM := rm -rf
RMDIR := rm -rf

# The following options can be controlled on the command line by supplying a 
# defintion, e.g.: make BUILDRESULTS=output/ DEBUG=1.
#
# BUILDRESULTS: the workibng directory in which to build outputs from sources.
# DEBUG: if non-zero, sets the build to a debug build. Default to release build.
# XML_LINK_INFO: path and name of the link info build artifact.
# DATEOVERRIDE: if non-zero, the value is used to replace BUILD_DATE, which 
#  				allows a part build to be more accurately reproduced. Default to
# 				the current date and time returned by the date shell command.
#
# Defaults:
#	BUILDRESULTS:  build
# 	DEBUG:         0
#	XML_LINK_INFO: $(BUILDRESULTS)/$(OUTPUT_NAME)_linkInfo.xml
#	DATEOVERRIDE:  0
# 
BUILDRESULTS ?= $(CURDIR)/build_make
DEBUG ?= 0
XML_LINK_INFO ?= $(BUILDRESULTS)/$(OUTPUT_NAME)_linkInfo.xml
DATEOVERRIDE ?= 0

#region ITEMS_VARS

# Outputs.
# 
EXE_OUTPUTS += \
	$(BUILDRESULTS)/$(OUTPUT_NAME).out
BIN_OUTPUTS += \
	$(BUILDRESULTS)/$(OUTPUT_NAME).hex

# Dependencies
# 
# C2000ware
# Embedded HAL C
# 
C2000WARE_ROOT := $(PROJECT_HOME_DIR)/subprojects/c2000ware-core-sdk
EMBEDDED_HAL_C := $(PROJECT_HOME_DIR)/subprojects/embedded-hal-c

# All project sources and include dirs must be listed here.
#
# CMD_SRCS: 	.cmd command files to be linked in.
# LIB_SRCS: 	.lib library files to be linked in.
# ASM_SRCS: 	.asm source files to be compiled in.
# C_SRCS:   	.c source files to be compiled in.
# LINKED_LIBS: 	libs that require an -l flag with the linker.
# INC_DIRS: 	include dirs for search path, prepended with -I.
# 
CMD_SRCS := \
	src/2837xD_RAM_lnk_cpu1.cmd
LIB_SRCS := \

ASM_SRCS := \
	src/device/F2837xD_CodeStartBranch.asm
C_SRCS := \
	src/device/device.c \
	src/i2c_ex3_external_loopback.c
LINKED_LIBS := \
	$(CG_TOOL_ROOT)/lib/libc.a

# Set all include dirs, then add -I flag for TI-CGT C2000.
# 
INC_DIRS := \
	$(CG_TOOL_ROOT)/include \
	$(CG_TOOL_ROOT)/lib \
	src/device \
	$(C2000WARE_ROOT)/driverlib/f2837xd/driverlib \
	$(EMBEDDED_HAL_C)/inc
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

# Generate lists of file names from sources.
#
# %.c -> $(BUILDRESULTS)/%.d
# %.asm -> $(BUILDRESULTS)/%.d
# %.c + %.asm -> $(BUILDRESULTS)/%.obj
# % -> -l%
# 
ASM_DEPS := $(ASM_SRCS:%.asm=$(BUILDRESULTS)/%.d)
C_DEPS := $(C_SRCS:%.c=$(BUILDRESULTS)/%.d)
OBJS := $(C_SRCS:%.c=$(BUILDRESULTS)/%.obj) $(ASM_SRCS:%.asm=$(BUILDRESULTS)/%.obj)

# Add -l flag for TI-CGT C2000 linker.
# 
FORMATTED_LINKED_LIBS := $(LINKED_LIBS:%=-l%)

# Assemble all items in order for the linker.
# 
ORDERED_OBJS += \
	$(OBJS) \
	$(CMD_SRCS) \
	$(LIB_SRCS) \
	$(FORMATTED_LINKED_LIBS)

#endregion ITEMS_VARS

#region FLAGS

# Flags set with DEBUG setting.
#
# Defaults to release, which is just -O3.
# DEBUG=1 runs a debug build, which is -g -O2.
ifeq ($(DEBUG),1)
# Reduce optimization, too.
CL2000_FLAGS += -g -O2 -DDEBUG
LIB_SRCS += $(C2000WARE_ROOT)/driverlib/f2837xd/driverlib/ccs/Debug/driverlib_eabi.lib
else
CL2000_FLAGS += -O3 -DRELEASE -DNDEBUG
LIB_SRCS += $(C2000WARE_ROOT)/driverlib/f2837xd/driverlib/ccs/Release/driverlib_eabi.lib
endif

# Flags.
#
# CL2000_FLAGS: compiler flags for .c and .asm.
# LINKER_FLAGS: linker flags included after the -z flag.
# 
CL2000_FLAGS += \
	-v28 \
	-ml \
	-mt \
    --cla_support=cla1 \
    --float_support=fpu32 \
    --tmu_support=tmu0 \
    --vcu_support=vcu2 \
    --diag_suppress=10063 \
    --diag_warning=225 \
    --diag_wrap=off \
    --display_error_number \
    --abi=eabi \
	--advice:performance=all
LINKER_FLAGS := \
	-m$(BUILDRESULTS)/$(OUTPUT_NAME).map \
	--heap_size=0x200 \
	--stack_size=0x3F8 \
	--warn_sections \
	-i$(CG_TOOL_ROOT)/lib \
	-i$(CG_TOOL_ROOT)/include \
	--reread_libs \
	--diag_wrap=off \
	--display_error_number \
	--xml_link_info="$(XML_LINK_INFO)" \
	--entry_point=code_start \
	--rom_model

# Predefined macro options.
#
# DEFINES: 		each will be added with a -D flag.
# UNDEFINES: 	each will be added with a -U flag.
DEFINES := \
	RAM \
	F2837xD \
	CPU1
DEFINE_FLAGS := $(addprefix -D,$(DEFINES))
UNDEFINES := \

UNDEFINE_FLAGS := $(addprefix -U,$(UNDEFINES))

# Store date.
#
# BUILD_DATE: defaults to current date as returned by the date shell command in 
# %d/%m/%Y, %H:%M format.
# Setting DATEOVERRIDE to a non-zero value will use DATEOVERRIDE as BUILD_DATE 
# instead. This supports deterministic builds, which allows a past build to be more 
# accurately reproduced.
ifeq ($(DATEOVERRIDE),0)
BUILD_DATE := $(shell date -u +"%d/%m/%Y, %H:%M")
else
BUILD_DATE := $(DATEOVERRIDE)
endif

# Store build user and hostname of machine.
BUILD_MACHINE := $(shell echo `whoami`@`hostname`)

# Generate build tag and build info.
# REF: https://embeddedartistry.com/blog/2016/12/21/giving-your-firmware-build-a-version/
version := $(subst -, ,$(shell git describe --long --dirty --tags))
COMMIT := $(strip $(word 3, $(version)))
COMMITS_PAST := $(strip $(word 2, $(version)))
DIRTY := $(strip $(word 4, $(version)))
ifneq ($(COMMITS_PAST), 0)
	BUILD_INFO_COMMITS := "."$(COMMITS_PAST)
endif
ifneq ($(DIRTY),)
	BUILD_INFO_DIRTY :="+"
endif
export BUILD_TAG :=$(strip $(word 1, $(version)))
export BUILD_INFO := $(COMMIT)$(BUILD_INFO_COMMITS)$(BUILD_INFO_DIRTY)

# Build metadata automatically included.
#
# _VERSION_BUILD_DATE_: 	Time/date of build
# _VERSION_BUILD_MACHINE_: 	Machine that built it (USER@HOST)
# _VERSION_TAG: 			last git tag number	
# _VERSION_BUILD_:			(commit).(num commits past last tag)(+ if dirty)
DEFINE_FLAGS := \
	$(DEFINE_FLAGS) \
	-D_VERSION_BUILD_DATE_=\""$(BUILD_DATE)"\" \
	-D_VERSION_BUILD_MACHINE_=\""$(BUILD_MACHINE)"\" \
	-D_VERSION_TAG_=\"$(BUILD_TAG)\" \
	-D_VERSION_BUILD_INFO_=\"$(BUILD_INFO)\"

#endregion FLAGS

#region COMPILATION_RULES

# Rule for all .c source files.
$(BUILDRESULTS)/%.obj: %.c
	mkdir -p $(@D)
	@echo 'Building file: "$<"'
	@echo 'Invoking: C2000 Compiler'
	$(CG_TOOL_ROOT)/bin/cl2000 $(CL2000_FLAGS) $(INC_FLAGS) $(DEFINE_FLAGS) $(UNDEFINE_FLAGS) --preproc_with_compile --preproc_dependency=$(@D)/$(basename $(<F)).d_raw --obj_directory=$(@D) $(shell echo $<)
	@echo 'Finished building: "$<"'
	@echo ' '

# Rule for all .asm source files.
$(BUILDRESULTS)/%.obj: %.asm
	mkdir -p $(@D)
	@echo 'Building file: "$<"'
	@echo 'Invoking: C2000 Compiler'
	$(CG_TOOL_ROOT)/bin/cl2000 $(CL2000_FLAGS) $(INC_FLAGS) $(DEFINE_FLAGS) $(UNDEFINE_FLAGS) --preproc_with_compile --preproc_dependency=$(@D)/$(basename $(<F)).d_raw --obj_directory=$(@D) $(shell echo $<)
	@echo 'Finished building: "$<"'
	@echo ' '

#endregion COMPILATION_RULES

#region ALL_TARGET

# Paralellize build.
NPROCS = $(shell grep -c 'processor' /proc/cpuinfo)
MAKEFLAGS += -j$(NPROCS)

# All Target -- builds .out and .hex files.
all: $(OBJS) $(CMD_SRCS) $(LIB_SRCS) $(LINKED_LIBS)
	@$(MAKE) $(BUILDRESULTS)/$(OUTPUT_NAME).out
	@$(MAKE) --no-print-directory -Onone $(BUILDRESULTS)/$(OUTPUT_NAME).hex

$(BUILDRESULTS)/$(OUTPUT_NAME).out: $(OBJS) $(CMD_SRCS) $(LIB_SRCS) $(LINKED_LIBS)
	mkdir -p $(@D)
	@echo 'Building target: "$@"'
	@echo 'Invoking: C2000 Linker'
	$(CG_TOOL_ROOT)/bin/cl2000 $(CL2000_FLAGS) $(DEFINE_FLAGS) $(UNDEFINE_FLAGS) -z $(LINKER_FLAGS) -o $(BUILDRESULTS)/$(OUTPUT_NAME).out $(ORDERED_OBJS) $(LINKED_LIBS)
	@echo 'Finished building target: "$@"'
	@echo ' '

$(BUILDRESULTS)/$(OUTPUT_NAME).hex: $(EXE_OUTPUTS)
	mkdir -p $(@D)
	@echo 'Building secondary target: "$@"'
	@echo 'Invoking: C2000 Hex Utility'
	$(CG_TOOL_ROOT)/bin/hex2000 -i -romwidth 16 -o $(BUILDRESULTS)/$(OUTPUT_NAME).hex $(EXE_OUTPUTS)
	@echo 'Finished building secondary target: "$@"'
	@echo ' '

# TODO Add rule for creating enc file.

#endregion ALL_TARGET

#region ADDITIONAL_TARGETS

.PHONY: version
version:
	@echo "BUILD_DATE:    $(BUILD_DATE)"
	@echo "BUILD_MACHINE: $(BUILD_MACHINE)"
	@echo "BUILD_TAG:     $(BUILD_TAG)"
	@echo "BUILD_INFO:    $(BUILD_INFO)"
	@echo ' '
	@echo 'Finished running version target.'
	@echo ' '

.PHONY: clean
clean:
	$(RM) $(BUILDRESULTS)
	@echo ' '
	@echo 'Finished clean.'
	@echo ' '

.PHONY : help
help :
	@echo "usage: make [OPTIONS] <target>"
	@echo "  Options:"
	@echo "    > BUILDRESULTS Directory for build results. Default buildresults."
	@echo "    > DEBUG Enable a debug build. Default 0 (release). Enable with 1."
	@echo "    > XML_LINK_INFO: path and name of the link info build artifact."
	@echo "    > DATEOVERRIDE: if non-zero, the value is used to replace BUILD_DATE,"
	@echo "        which allows a part build to be more accurately reproduced."
	@echo "        Defaults to the current date and time returned by the date shell"
	@echo "        command." 
	@echo "Targets:"
	@echo "  default: build all default targets"
	@echo "  clean: remove build artifacts and configured build output directories"
	@echo "  Static Analysis:"
	@echo "    version: prints build metadata"
	@echo ' '

#endregion ADDITIONAL_TARGETS
