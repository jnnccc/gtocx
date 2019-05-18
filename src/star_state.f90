subroutine star_state(id,t,x)
use module_mod
implicit none

integer*8, intent(in) :: id  ! star id
real(dp), intent(in):: t     ! epoch [yr]
real(dp), intent(out)::x(6)  ! state of star 

integer*8 :: index
real(dp) :: r,n,v,phi,omega,i

index = id+1
r = stars(index)%par(1)
phi =   stars(index)%par(4)
omega = stars(index)%par(3)
i =     stars(index)%par(2)
v = 1.d0/(k(1)+k(2)*r+k(3)*r**2+k(4)*r**3+k(5)*r**4+k(6)*r**5+k(7)*r**6+k(8)*r**7+k(9)*r**8)
v = v/vel
n = v/r
x(1) = r*(cos(n*t+phi)*cos(omega)-sin(n*t+phi)*cos(i)*sin(omega))
x(2) = r*(cos(n*t+phi)*sin(omega)+sin(n*t+phi)*cos(i)*cos(omega))
x(3) = r*(sin(n*t+phi)*sin(i))
x(4) = v*(-sin(n*t+phi)*cos(omega)-cos(n*t+phi)*cos(i)*sin(omega))  
x(5) = v*(-sin(n*t+phi)*sin(omega)+cos(n*t+phi)*cos(i)*cos(omega))  
x(6) = v*(cos(n*t+phi)*sin(i))

end subroutine star_state

