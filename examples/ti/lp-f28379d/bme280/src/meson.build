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
    '/root/ti/cgt/ti-cgt-c2000_22.6.1.LTS/include',
    '/root/ti/cgt/ti-cgt-c2000_22.6.1.LTS/lib',
    # '..' / 'subprojects' / 'c2000ware-core-sdk' / 'driverlib' / 'f2837xd' / 'driverlib',
    'device',
]

# Application source files.
# 
# The same pattern is used as with includes for consistency. One the array is
# final, it's passed to the files() function.
# 
app_src_files = [
    'main.c',
    'device/F2837xD_CodeStartBranch.asm',
    'device/device.c',
]

# Lists of includes and sources are final, so we can create the Meson objects
# for the executable without running into limitations of operations. 
# 
all_app_include_dirs = include_directories(app_include_dirs_arr)
all_app_src_files = files(app_src_files)

linker_script = meson.current_source_dir() / '2837xD_RAM_lnk_cpu1.cmd'
# driverlib = '..' / 'subprojects' / 'c2000ware-core-sdk' / 'driverlib' / 'f2837xd' / 'driverlib' / 'ccs' / 'Debug' / 'driverlib.lib'

cl2000 = meson.get_compiler('c')
cl2000_path = cl2000.cmd_array()[0]

message('cl2000: ' + cl2000.version())
message('cl2000_path: ' + cl2000_path)

# cl2000 [options] [filenames] [--run_linker [link_options] object files]]

# Compile source files but don't link yet
# objs = []
# foreach src : all_app_src_files
#     src_full_path = src.full_path()
#     src_name = src_full_path.split('/')[-1]  # Extract the file name from the full path
#     obj_name = src_name.split('.')[0] + '.obj'  # Create object file name
#     obj_path = src_full_path.split('.')[0] + '.obj'

#     message('obj_name: ' + obj_name)

#     obj = custom_target(
#         obj_name,
#         input: src,
#         output: obj_name,
#         command: [cl2000_path, desired_c_compile_flags, '-I/root/ti/cgt/ti-cgt-c2000_22.6.1.LTS/include', src_full_path, obj_path + '@OUTPUT@'],
#         build_by_default: true
#     )
#     objs += obj
# endforeach


# Custom target for linking
# executable_target = custom_target(
#   'link',
#   output: app_executable_name + '.out',
#   input: objs,
#   command: [cl2000_path, '-z', c_l_flags, '-o', '@OUTPUT@', 'main.obj', 'F2837xD_CodeStartBranch.obj', linker_script, '-llibc.a'],
# #   depend_files: objs,
#   build_by_default: true
# )

# Excutable target for the application.
# 
app_exe = executable(app_executable_name,
	all_app_src_files,
	include_directories: [
        all_app_include_dirs,
        embedded_hal_c_includes,
        f2837xd_driverlib_include
    ],
    c_args: [desired_c_compile_flags],
	link_args: [linker_script, f2837xd_driverlib[0].full_path(), c_l_flags, '-llibc.a'],
	# cpp_args: compiler_flags, # Added directly in the top-level Meson module.
    # override_options: [
    #     'cpp_std=c++' + cpp_language_ver, 
    #     'build.cpp_std=c++' + cpp_language_ver
    # ]
)
