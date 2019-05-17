Code of ships and pods trajectory propagation for GTOCX competition 

## Building & Running

```
mkdir build
cd build
cmake ..
make -j12
./gtocx
```

## Functions  

1. modules to read stars.txt
2. some unit conversions[km/s-->kpc/myr, degree-->radian] 
3. compute the state[x,y,z,vx,vy,vz] of stars at time t
4. ship propagation using KSG integrator

## Files 

1. ./src/force_driv.f90         2nd order differential equation
2. ./src/init.f90               integrator initiation
3. ./src/module.f90             common block
4. ./src/propag.f90             ship propagation
5. ./src/read_stars.f90         read stars database
6. ./src/star_state.f90         read stars database
7. ./src/test.f90               code check 

