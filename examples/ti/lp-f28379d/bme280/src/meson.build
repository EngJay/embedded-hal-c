##
# Meson module for the `src` directory.
#
# This module is reponsible for:
#
#   - Gathering the includes and sources needed for the build.
#   - Defining the executable.
#   - Providing targets for conversion to alternative binary formats.
#

# The name of the excutable file to be created.
#
app_executable_name = 'example-i2c-ti-lp-f28379d-bme280'

# Application include directories.
#
# An array is created first in order to use operations not available on the
# Meson include_directories object. The include_directories() function does take
# an array, so once the array is final, it can be passed to the function to
# create the object to pass to the executable() function.
#
app_include_dirs_arr = [
    ti_c28x_c2000_cgt_dir / 'include',
    ti_c28x_c2000_cgt_dir / 'lib',
    'device',
]

# Application source files.
#
# The same pattern is used as with includes for consistency. One the array is
# final, it's passed to the files() function.
#
app_src_files = [
    'i2c_ex3_external_loopback.c',
    # 'main.c',
    'device/F2837xD_CodeStartBranch.asm',
    'device/device.c',
]

# Lists of includes and sources are final, so we can create the Meson objects
# for the executable without running into limitations of operations.
#
all_app_include_dirs = include_directories(app_include_dirs_arr)
all_app_src_files = files(app_src_files)

linker_script = meson.current_source_dir() / '2837xD_RAM_lnk_cpu1.cmd'

# This is faulty because it adds a flag `-lc` at the end of the linker args but
# the C28x compiler expects it in the form `-llibc.a` and at the very end of the
# command after the input object files.
#
# cc = meson.get_compiler('c')
# c2000_libc = cc.find_library('c', dirs: ti_c28x_c2000_cgt_dir / 'lib', static: true)

# TODO adopt the meson executable target when Meson can support TI C28x, #3.
#
# Meson can't handle the format needed to build TI C28x projects.

# Excutable target for the application.
#
# app_exe = executable(app_executable_name,
# 	all_app_src_files,
# 	include_directories: [
#         all_app_include_dirs,
#         embedded_hal_c_includes,
#         f2837xd_driverlib_include
#     ],
#     c_args: [desired_c_compile_flags],
# 	link_args: [linker_script, f2837xd_driverlib[0].full_path(), c_l_flags],
#     # dependencies: [c2000_libc]
# 	# cpp_args: compiler_flags, # Added directly in the top-level Meson module.
#     # override_options: [
#     #     'cpp_std=c++' + cpp_language_ver,
#     #     'build.cpp_std=c++' + cpp_language_ver
#     # ]
# )
