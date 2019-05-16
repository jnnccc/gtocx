cmake_minimum_required(VERSION 3.10)

project(gtocx)

# Search path for CMake include files.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
	${CMAKE_CURRENT_SOURCE_DIR}/cmake
	${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/gtocx-compilers)

include(CompilerFlags)

# Default to debug build
#set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_BUILD_TYPE Release)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/ksg)

set(GTOCX_SRCS
	src/force_driv.f90
	src/init.f90
	src/module.f90
	src/propag.f90
	src/read_stars.f90
	src/star_state.f90
	src/main.f90)

add_executable(${PROJECT_NAME} ${GTOCX_SRCS})
target_compile_options(${PROJECT_NAME} PRIVATE "-ffree-line-length-none")
target_link_libraries(${PROJECT_NAME} ksg)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/database ${CMAKE_CURRENT_BINARY_DIR}/database
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/database
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Copying database folder")
