if (NOT GTOCX_COMPILERS_SET)

enable_language(Fortran)
enable_language(CUDA)

if (NOT ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU"))
message(FATAL_ERROR "Unknown compiler ${CMAKE_C_COMPILER}, please add optimization flags for it into CompilerFlags.cmake")
endif ()

if (NOT ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU"))
message(FATAL_ERROR "Unknown compiler ${CMAKE_CXX_COMPILER}, please add optimization flags for it into CompilerFlags.cmake")
endif ()

if (NOT ("${CMAKE_Fortran_COMPILER_ID}" STREQUAL "GNU"))
message(FATAL_ERROR "Unknown compiler ${CMAKE_Fortran_COMPILER}, please add optimization flags for it into CompilerFlags.cmake")
endif ()

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -finit-local-zero")

set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -DNDEBUG -g -ffast-math")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -DNDEBUG -g -ffast-math")
set(CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_Fortran_FLAGS_RELEASE} -DNDEBUG -g -ffast-math")
set(CMAKE_CUDA_FLAGS_RELEASE "-DNDEBUG -g --use_fast_math -lineinfo -Xcompiler=-ffast-math ${CMAKE_CUDA_FLAGS_RELEASE}")

set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g -O0")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0")
set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -g -O0")
set(CMAKE_CUDA_FLAGS_DEBUG "-D_DEBUG -g -G -O0 ${CMAKE_CUDA_FLAGS_DEBUG}")

set(GTOCX_COMPILERS_SET TRUE)

endif ()

