SHELL := /bin/bash
all:
	(cd src/ksglib/ ;touch modules.flags; make depend; make)
#	(cd src/spicelib/ ;touch modules.flags; make depend; make)
#	(cd src/slateclib/ ;touch modules.flags; make depend; make)
	(cd src;   touch modules.flags; make depend; make)
clean:
	(rm bin/*.x ;cd src; make clean)
	(cd src/ksglib/ ; make clean)
#	(cd src/spicelib/ ; make clean)
#	(cd src/slateclib/ ; make clean)

mker:
	bin/mker $(kerdir)
run0:
	(cd input; rm driv*; ln -s $(driv)/* .; cd ..)
	setsid bin/RsrPkg.x $(mode) >/dev/null &
run1:
	(cd input; rm driv*; ln -s $(mission)/driv* .; cd ..)
	bin/RsrPkg.x  $(mode)
run2:
	shell/gnup_occ 
kill:
	bin/trsim_0
testomp:
	time bin/test_omp.x
debug:
	bin/idbx
profile-tex:
	gprof bin/RsrPkg.x  >/tmp/profile
	vi /tmp/profile
profile:
	vprof bin/RsrPkg.x 
update:
	bin/update
	make clean
	make
updata:
	bin/updata
bak:
	rsync -e 'ssh -p 2280' -vzrtlopg --delete --progress ~/work/RsrPkg/ jnc@home:/home/jnc/work/RsrPkg/ 

