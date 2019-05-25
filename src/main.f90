program main
use module_mod
implicit none

real(dp) :: x(6), x0(6), x00(6), x1(6), t0, t1, x1_p(6)
integer*8 :: id, i

! Read star data base
call read_stars

! Get star state
id = 0
do id = 0, 100
! Ships propagation  
call integrator_init
!id = 0
call star_state(id, 0.d0, x0)
x0(4)=x0(4)+300.d0/vel
x0(5)=x0(5)+500.d0/vel
x0(6)=x0(6)+500.d0/vel
do i = 0,100
  t0 = 0.d0 ! start from Sol
  t1 = t0 + dble(i) * 1d0
  call propag(t0, x0, t1, x1)
  call propag_validator(t0, x0, t1, x1_p)
!  write(*,'(f8.3,6e18.10)') t1, x1_p - x1
  if(ANY(ABS(x1_p - x1) > 1e-4))then
      write(*, *) "Error at time", t1, id
  else
      write(*, *) "Error meets requirement at time", t1, id
  end if
enddo
end do

end program main

