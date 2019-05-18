cmake_minimum_required(VERSION 3.10)

project(ksg)

enable_language(Fortran)

set(KSG_SRCS
	src/bckdif.f
	src/ksg2ut.f
	src/ksgco.f
	src/ksgcos.f
	src/ksgdr.f
	src/ksgfs.f
	src/ksgfs0.f
	src/remark.f
	src/sgntrp.f
	src/sgstep.f
	src/sgstrt.f
	src/taylor.f
	src/ut2ksg.f)

add_library(${PROJECT_NAME} STATIC ${KSG_SRCS})
target_compile_options(${PROJECT_NAME} PRIVATE "-ffixed-line-length-none")
