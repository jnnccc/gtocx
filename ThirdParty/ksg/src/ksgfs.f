      subroutine ksgfs (deriv,x,n,m,tin,tout,h,work,iflag,zzdt,alim,
     *                  nloop)
c
c...purpose:  Krogh-Shampine-Gordon fixed-step multi-step integrator
c             for second order differential equations
c
c...coded by:  J Lundberg  -  UT austin  -  June 1980
c
c...adapted for utopia by:  J Ries - UT austin - Sept 1982
c   restart option added by:  J Ries - UT austin - Sept 1983
c
c...formal parameters:
c
c     n      number of second order differential equations
c     m      order of integration (not to exceed 16)
c     work   work space
c     zzdt   indicates variational equations are also being integrated
c
c        other variables explained in ksgdr
c
      implicit real *8 (a-h,o-z)
      logical zzdt
      dimension x(6), work(5+2*n+2*n*m), alim(3)
c
      external deriv
c
c	  write(*,*)x,x(n+1)
c	  stop
      is = 6
      isd = is+n
      iwk = isd+n
      if = iwk+n*m
c
      if (zzdt) call ut2ksg (x,n)
c
      call ksgdr (n,m,tin,tout,h,x,x(n+1),deriv,work(1),work(2),work(3),
     *      work(4),work(5),work(is),work(isd),work(iwk),work(if),iflag,
     *      alim,nloop)
c
      if (zzdt) call ksg2ut (x,n)
c
      return
c
c.....end ksgfs
      end
