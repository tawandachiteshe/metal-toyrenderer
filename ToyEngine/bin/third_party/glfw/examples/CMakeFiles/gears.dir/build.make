# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/__declspec/CLionProjects/metal-toyrenderer/SandBox

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/__declspec/CLionProjects/metal-toyrenderer/SandBox/cmake-build-debug

# Include any dependencies generated for this target.
include /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/depend.make

# Include the progress variables for this target.
include /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/progress.make

# Include the compile flags for this target's objects.
include /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/flags.make

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/Resources/glfw.icns: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/examples/glfw.icns
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Copying OS X content /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/Resources/glfw.icns"
	$(CMAKE_COMMAND) -E copy /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/examples/glfw.icns /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/Resources/glfw.icns

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/gears.c.o: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/flags.make
/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/gears.c.o: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/examples/gears.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/__declspec/CLionProjects/metal-toyrenderer/SandBox/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/gears.c.o"
	cd /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples && /Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/gears.dir/gears.c.o -c /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/examples/gears.c

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/gears.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gears.dir/gears.c.i"
	cd /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples && /Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/examples/gears.c > CMakeFiles/gears.dir/gears.c.i

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/gears.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gears.dir/gears.c.s"
	cd /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples && /Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/examples/gears.c -o CMakeFiles/gears.dir/gears.c.s

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/__/deps/glad_gl.c.o: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/flags.make
/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/__/deps/glad_gl.c.o: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/deps/glad_gl.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/__declspec/CLionProjects/metal-toyrenderer/SandBox/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/__/deps/glad_gl.c.o"
	cd /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples && /Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/gears.dir/__/deps/glad_gl.c.o -c /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/deps/glad_gl.c

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/__/deps/glad_gl.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gears.dir/__/deps/glad_gl.c.i"
	cd /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples && /Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/deps/glad_gl.c > CMakeFiles/gears.dir/__/deps/glad_gl.c.i

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/__/deps/glad_gl.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gears.dir/__/deps/glad_gl.c.s"
	cd /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples && /Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/deps/glad_gl.c -o CMakeFiles/gears.dir/__/deps/glad_gl.c.s

# Object files for target gears
gears_OBJECTS = \
"CMakeFiles/gears.dir/gears.c.o" \
"CMakeFiles/gears.dir/__/deps/glad_gl.c.o"

# External object files for target gears
gears_EXTERNAL_OBJECTS =

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/MacOS/gears: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/gears.c.o
/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/MacOS/gears: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/__/deps/glad_gl.c.o
/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/MacOS/gears: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/build.make
/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/MacOS/gears: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/src/libglfw3.a
/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/MacOS/gears: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/__declspec/CLionProjects/metal-toyrenderer/SandBox/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable gears.app/Contents/MacOS/gears"
	cd /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gears.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/build: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/MacOS/gears
/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/build: /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/gears.app/Contents/Resources/glfw.icns

.PHONY : /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/build

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/clean:
	cd /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples && $(CMAKE_COMMAND) -P CMakeFiles/gears.dir/cmake_clean.cmake
.PHONY : /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/clean

/Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/depend:
	cd /Users/__declspec/CLionProjects/metal-toyrenderer/SandBox/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/__declspec/CLionProjects/metal-toyrenderer/SandBox /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/third_party/glfw/examples /Users/__declspec/CLionProjects/metal-toyrenderer/SandBox/cmake-build-debug /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : /Users/__declspec/CLionProjects/metal-toyrenderer/ToyEngine/bin/third_party/glfw/examples/CMakeFiles/gears.dir/depend

