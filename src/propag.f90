subroutine propag(t0,x0,t1,x1)
use module_mod

implicit none
real(dp),intent(in):: t0,t1,x0(6)     ! epoch [yr] and state
real(dp),intent(out)::x1(6)  ! state of star 

!TYPE(orbit_elem), INTENT(IN) :: x0 !m,m/s
!TYPE(orbit_elem), INTENT(inout) :: x1 !m/m/s
integer(kind=2):: nloop
!logical zzdt
real(dp) x(6),tin,tout!,work(1000)!,h,work(1000000),alim(3)
external deriv1
       tin=t0
       x=x0
       tout=t1
!       write(*,*)'integ:', tin,tout
!		write(*,'(20f20.3)')ksg%work(7:26)
    call ksgfs (deriv1,x,3,15,tin,tout,h_ksg,work_ksg(7),iflag_ksg,.false.,alim_ksg,nloop)

!      call markhere
!      write(*,*)ksg%iflag
       if (iflag_ksg.ne.2)then
           write(*,*)'error with integration ',' iflag=',iflag_ksg
            stop
       endif
      x1=x
endsubroutine propag


