!> @brief 定义积分器调用的函数
!>@see Moyer T D. Mathematical formulation of the Double Precision Orbit Determination Program/DPODP[J]. 1971.
!>@author 
!!NC.Jian jnnccc@shao.ac.cn 
!>@date 2016-05-19 

SUBROUTINE deriv1(T,x,dx)
use module_mod
!SSB center
!use general_mod, only: refet_orb
!use force_mod
implicit none
DOUBLE PRECISION::  T,r,v,f
DOUBLE PRECISION::  x(6), dx(6)

!write(*,*)'cccccccccccccccccccccccc'
!write(*,*)t,x
      r=dsqrt(x(1)**2+x(2)**2+x(3)**2)	
      v=1.d0/(k(1)+k(2)*r+k(3)*r**2+k(4)*r**3+k(5)*r**4+k(6)*r**5+ k(7)*r**6+k(8)*r**7+k(9)*r**8)
      v=v/vel !km/s ---> kpc/myr 
      f=v**2/r

     dx(1)=-x(1)*f/r
     dx(2)=-x(2)*f/r
     dx(3)=-x(3)*f/r
      return

!call force(T+refet_orb,y,yp(1:3))
endSUBROUTINE deriv1


