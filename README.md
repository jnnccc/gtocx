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
```
modules to read stars.txt
some unit conversions[km/s-->kpc/myr, degree-->radian] 
compute the state[x,y,z,vx,vy,vz] of stars at time t
ship propagation using KSG integrator
```

## Files 
+ ./src/force_driv.f90         2nd order differential equation
+ ./src/init.f90               integrator initiation
+ ./src/module.f90             common block
+ ./src/propag.f90             ship propagation
+ ./src/read_stars.f90         read stars database
+ ./src/star_state.f90         compute star state[x,y,z,vx,vy,vz][kpc|myr] from [<math
xmlns="http://www.w3.org/1998/Math/MathML" display="block">
<mrow><mi>R</mi><mi>,</mi><mi>i</mi><mi>,</mi><mi>&#937;</mi><mi>,</mi><mi>&#966;</mi></mrow></math>] at time t[myr]
+ ./src/main.f90               checking code 
```

