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
<<<<<<< HEAD
```
modules to read stars.txt
some unit conversions[km/s-->kpc/myr, degree-->radian] 
compute the state[x,y,z,vx,vy,vz] of stars at time t
ship propagation using KSG integrator
```

## Files 
```
./src/force_driv.f90         2nd order differential equation
./src/init.f90               integrator initiation
./src/module.f90             common block
./src/propag.f90             ship propagation
./src/read_stars.f90         read stars database
./src/star_state.f90         compute star state[x,y,z,vx,vy,vz][kpc|myr] from $R,i,\Omega,\phi$ at time t[myr]
./src/main.f90               checking code 
```
=======

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

>>>>>>> 351eaba1f1b73bee7baba4fd4989e138be77bbef
