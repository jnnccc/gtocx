## introduction  
1. modules to read stars.txt
2. some unit conversion[km|s-->kpc/myr] 
3. compute the state of stars at time t
4. ship propagation

## files 
./compile          compile file
./force_driv.f90   two order differential equation
./gtoc_test        executive file
./init.f90         integrator initiation
./libksg.a         ksg integrator
./module.f90       common block
./module_mod.mod
./propag.f90       propagation
./readme.md        this file
./read_stars.f90   read stars database
./star_state.f90   get star state at time t
./stars.txt        stars database
./test.f90         test program

## todo
write a make file
add the ksg code
