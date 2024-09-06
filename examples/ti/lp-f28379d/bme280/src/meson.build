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
app_include_dirs_arr = []

# Application source files.
# 
# The same pattern is used as with includes for consistency. One the array is
# final, it's passed to the files() function.
# 
app_src_files = [
    'main.c'
]

# Lists of includes and sources are final, so we can create the Meson objects
# for the executable without running into limitations of operations. 
# 
all_app_include_dirs = include_directories(app_include_dirs_arr)
all_app_src_files = files(app_src_files)

# Excutable target for the application.
# 
app_exe = executable(app_executable_name,
	all_app_src_files,
	include_directories: all_app_include_dirs,
	link_args: [],
	# cpp_args: compiler_flags, # Added directly in the top-level Meson module.
    # override_options: [
    #     'cpp_std=c++' + cpp_language_ver, 
    #     'build.cpp_std=c++' + cpp_language_ver
    # ]
)
