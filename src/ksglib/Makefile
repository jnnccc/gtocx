include ../make.flags
include modules.flags
root=../../
#otherlib=ksglib/libksg.a spicelib/libspice.a
#mkllib=-lmkl_lapack95_lp64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lrkf
#flink= -lspice -lslatec -lpgplot -lspline -lstarpac $(mkllib) $(otherlib)
#fflink= $(flink) $(mkllib) 
#all: myflib myclib trsim differ_data comp_data rsrinfo
all:libksg.a
obj=bckdif.o  ksg2ut.o  ksgco.o ksgcos.o ksgdr.o  ksgfs0.o  ksgfs.o  remark.o  sgntrp.o  sgstep.o  sgstrt.o  taylor.o  ut2ksg.o

libksg.a: $(obj)
	$(AR) r $(root)/lib/libksg.a $(obj)
	ranlib $(root)/lib/libksg.a	
#test_omp.x: test_omp.f90 
#	$(FC) -openmp -O test_omp.f90  -o ../bin/test_omp.x

list: 
	grep -E 'PROGRAM|MODULE|SUBROUTINE|FUNCTION|CONTAINS' *.f90 >LIST.sub
	grep -i ' CALL ' *.f90  >LIST.call 


depend:
	mkdep90   *.f  >make.dep
	mkmoddep -f ../.compiler ./   > modules.flags
clean:
	rm -f  *.o *.a *.mod *% *~ core 
# Dependencies
#include make.dep
 
