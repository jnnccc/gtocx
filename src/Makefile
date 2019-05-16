include make.flags
include modules.flags
root=../
#root1=/home/jnc/work/RsrPkgOmp/src
#otherlib=ksglib/libksg.a spicelib/libspice.a
otherlib=$(root)lib/libksg.a #spicelib/libspice.a #slateclib/libslatec.a
#mkllib=-lmkl_lapack95_lp64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread #-lrkf
#flink= -lspice -lslatec -lpgplot -lspline -lstarpac $(mkllib) $(otherlib)
fflink= $(flink) $(mkllib) $(otherlib)
#all: myflib myclib trsim differ_data comp_data rsrinfo
all:gtoclib gtocx 
obj= force_driv.o  init.o  module.o  propag.o  read_stars.o  star_state.o
gtoclib:$(obj)
	ar rc $(root)lib/libgtoc.a $(obj)
	$(RANLIB) $(root)lib/libgtoc.a     

gtocx: test.o $(obj)
	$(FC) $(FFLAGS) test.o $(obj)  $(fflink)  -o $(root)/bin/gtocx

#test_omp.x: test_omp.f90 
#	$(FC) -openmp -O test_omp.f90  -o ../bin/test_omp.x

list: 
	grep -E 'PROGRAM|MODULE|SUBROUTINE|FUNCTION|CONTAINS' *.f90 >LIST.sub
	grep -i ' CALL ' *.f90  >LIST.call 


depend:
	mkdep90     *.f90  >make.dep
	mkmoddep -f .compiler ./ $(root)src/ $(root)src/include/  > modules.flags
clean:
	rm -f  *.o *.mod *% *~ core ../lib/libgtoc.a
# Dependencies
include make.dep
 
