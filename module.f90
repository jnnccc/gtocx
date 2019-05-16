module module_mod

implicit none

integer,parameter :: sp = selected_real_kind(p=6,r=37)
integer,parameter :: dp = selected_real_kind(p=15,r=307)
integer,parameter :: qp = selected_real_kind(p=33,r=4931)

real(dp), parameter :: k(9)=[2.87729d3,2.3821d3,1.0625d3,1.98502d4,-1.88428d-05 ,9.70521d-07 ,-2.70559d-08 ,3.7516d-10,-1.94316d-12]
real(dp), parameter :: pi = dacos(-1.d0)
real(dp), parameter :: rpd=DACOS ( -1.D0 ) / 180.D0
real(dp), parameter :: dpr=180.d0/DACOS ( -1.D0 ) 

real(dp), parameter :: kpc=3.08567758146719d16
real(dp), parameter :: myr=3.15576d13
real(dp), parameter :: vel=kpc/myr



TYPE stars1
    integer:: id       !星历目标名称
    real*8:: par(5)
end type stars1

type(stars1)::stars(100001)

! parameters for ksg 
integer(kind=4) :: iflag_ksg
real(dp)::h_ksg,alim_ksg(3),work_ksg(1000000)
!end type ksg_par
!type(ksg_par)::ksg
contains

subroutine markhere()
write(0,*)'                                                '
write(0,*)'                                                '
write(0,*)'                                                '
write(0,*)'------------12345678901234567890-------------|--'
endsubroutine markhere











end module module_mod
