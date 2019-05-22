subroutine error(er,etheta)
! compute error function E_r and E_theta
use module_mod
implicit none
real(dp),intent(out):: er , etheta
real(dp):: Rk,Tk
integer(kind=2) :: k

!compute E_r
er=0
do k=0,30
      Rk=dble(k)+2.d0          !kpc
      er=er+(sumfr(Rk)/gr(Rk)-1.d0)**2
enddo

!compute E_theta
etheta=0
do k=0,32
      Tk=-pi+pi*dble(k)/16.d0  !rad
      etheta=etheta+(sumft(Tk)/gt(Tk)-1.d0)**2
enddo

contains

function f(x,mu,s)
!函数定义 eq14
implicit none
real(dp):: f,x,mu,s

      if (abs(x-mu).gt.s) then
          f = 0.d0
      else
          f = 1.d0/s+abs(x-mu)/s**2
      endif

endfunction
      

function sumfr(r)
! f_r函数求和 eq15
implicit none
real(dp):: sumfr,r,ri
integer(kind=8)::i,id
sumfr=0.d0
      do i=1,settle_star%N
        id=settle_star%id_list(i)   !获取定居星id
        ri=stars(id)%par(1)         !获取定居星轨道半径
        sumfr=sumfr+f(r,ri,sr)
      enddo
sumfr=sumfr/dble(settle_star%N)
endfunction

function sumft(theta)
! f_theta函数求和 eq16
implicit none
real(dp):: sumft,theta,ti
integer(kind=8)::i,id
sumft=0.d0
      do i=1,settle_star%N
        id=settle_star%id_list(i)   !获取定居星id
        ti=stars(id)%par(5)         !获取定居星最终的极角
        sumft=sumft+f(theta,ti,st)
      enddo
sumft=sumft/dble(settle_star%N)
endfunction

function gr(r)
! eq 17
implicit none
real(dp):: gr,r

      gr=alpha(r)*2.d0*r/(Rmax**2-Rmin**2)
endfunction
      
function gt(theta)
! eq 18
implicit none
real(dp):: gt,theta

      gt=beta(theta)/(2*pi)
endfunction
 

function alpha(r)
implicit none
real(dp):: alpha,r

      if (r.eq.2.d0) then
          alpha = 0.5833d0
      elseif (r.eq.32.d0) then
          alpha = 0.4948d0
      else
          alpha = 1.d0
      endif

endfunction

function beta(theta)
implicit none
real(dp):: beta,theta
    
      if (theta.eq.-pi) then
          beta = 0.5d0
      elseif (theta.eq.pi) then
          beta = 0.5d0
      else
          beta = 1.d0
      endif


endfunction

endsubroutine
