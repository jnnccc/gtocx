cmake_minimum_required(VERSION 3.10)

project(odepack)

enable_language(Fortran)

set(ODEPACK_SRCS
	src/opkdmain.f
	src/opkda1.f
	src/opkda2.f)

add_library(${PROJECT_NAME} STATIC ${ODEPACK_SRCS})

