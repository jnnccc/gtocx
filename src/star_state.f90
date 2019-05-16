subroutine star_state(id,t,x)
use module_mod
implicit none
integer*8,intent(in) :: id  ! star id
real(dp),intent(in):: t     ! epoch [yr]
real(dp),intent(out)::x(6)  ! state of star 
integer*8::index
real*8:: r,n,v
index=id+1
r=stars(index)%par(1)
v=1.d0/(k(1)+k(2)*r+k(3)*r**2+k(4)*r**3+k(5)*r**4+k(6)*r**5+k(7)*r**6+k(8)*r**7+k(9)*r**8)
v=v/vel
n=v/r
x(1)=r*(dcos(n*t+stars(index)%par(4))*dcos(stars(index)%par(3))-dsin(n*t+stars(index)%par(4))*dcos(stars(index)%par(2))*dsin(stars(index)%par(3)))
x(2)=r*(dcos(n*t+stars(index)%par(4))*dsin(stars(index)%par(3))+dsin(n*t+stars(index)%par(4))*dcos(stars(index)%par(2))*dcos(stars(index)%par(3)))
x(3)=r*(dsin(n*t+stars(index)%par(4))*dsin(stars(index)%par(2)))
x(4)=v*(-dsin(n*t+stars(index)%par(4))*dcos(stars(index)%par(3))-dcos(n*t+stars(index)%par(4))*dcos(stars(index)%par(2))*dsin(stars(index)%par(3)))  
x(5)=v*(-dsin(n*t+stars(index)%par(4))*dsin(stars(index)%par(3))+dcos(n*t+stars(index)%par(4))*dcos(stars(index)%par(2))*dcos(stars(index)%par(3)))  
x(6)=v*(dcos(n*t+stars(index)%par(4))*dsin(stars(index)%par(2)))

endsubroutine star_state
