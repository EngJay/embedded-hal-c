
app_executable_name = 'example-i2c-ti-lp-f28379d-bme280'

app_include_dirs_arr = []

app_src_files = [
    'main.c'
]

all_app_include_dirs = include_directories(app_include_dirs_arr)
all_app_src_files = files(app_src_files)

tests_exe = executable(app_executable_name,
	all_app_src_files,
	include_directories: all_app_include_dirs,
	link_args: [],
	# cpp_args: compiler_flags, # Added directly in the top-level Meson module.
    # override_options: [
    #     'cpp_std=c++' + cpp_language_ver, 
    #     'build.cpp_std=c++' + cpp_language_ver
    # ]
)