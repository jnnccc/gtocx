subroutine integrator_init
use module_mod
implicit none
!real(dp)::D1MACH
!   type(ksg_par)::ksg
!    ksg%n=3
!    ksg%m=15
!    ksg%zzdt=.false.
    iflag_ksg=1
    h_ksg=1.d-1
    work_ksg=0.d0
    alim_ksg(1)=7.0d-15
    alim_ksg(2)=1.0d-13
 
!    alim_ksg(1)=7.0d-15
!    alim_ksg(2)=1.0d-13
    alim_ksg(3)=0.0d+0
end subroutine integrator_init
