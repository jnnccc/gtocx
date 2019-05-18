program main
use module_mod
implicit none

real(dp) :: x(6), x0(6), x00(6), x1(6), t0, t1
integer*8 :: id, i

! Read star data base
call read_stars

! Get star state
id = 0
call star_state(id, 10.d0, x)

! Ships propagation  
call integrator_init

id = 123
t0 = 0.d0 ! start from Sol
call star_state(id, t0, x0)
x0(4)=x0(4)+300.d0/vel
x0(5)=x0(5)+500.d0/vel
x0(6)=x0(6)+500.d0/vel
do i = 1, 100
  t1 = t0 + dble(i) * 1d0
  call propag(t0, x0, t1, x1)
  write(*,'(f8.3,6e24.13)') t1, x1
enddo

end program main

