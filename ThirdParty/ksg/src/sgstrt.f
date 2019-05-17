      subroutine sgstrt (deriv,x,v,t,n,m,work,xf,vf,alim,nloop,h,f,
     *                   iflag)
c
c...purpose:  start integrator with a forward and backward prediction
c             and iterating to converge back difference table
c
c...variables:
c
c     deriv      name of routine that returns second derivatives
c     x,v        initial state and velocity vectors.  (x and v are a
c                continuous vector in the calling routine)
c     t          initial time on input;  time of last node on output.
c     n          number of second order differential equations.
c     m          order of integration (number of nodes)
c     f          table of function evaluations/back differences
c     work       workspace of length n*m
c     xf,vf      arrays of length n each that contain the
c                state and velocities at t=tf on output.
c                xf and vf must be a continuous vector.
c     alim       convergence criterion for starting.
c     nloop      number of iterations starter used to converge solution
c     h          step size to be used.
c
      implicit none

      integer :: n, m, nloop
      real(8) :: x(n), v(n), t, f(n,m), work(n, m), xf(n), vf(n), alim(3), h, anorm

      integer :: iflag, i, im1, im2, j, k, l, nmm, nmm2, nmm3
      real(16) :: sum1, sum2, g(16,16), b(16,16)
      real(8) :: tf, vmag, xmag, gmid(16), bmid(16), xfs(3),vfs(3)
c
      external deriv
c
      nmm = m - (m+1)/2
      nmm2 = nmm*nmm
      tf = t+m/2*h
      xmag = sqrt(x(1)**2+x(2)**2+x(3)**2)
      vmag = sqrt(v(1)**2+v(2)**2+v(3)**2)
c
c...use taylor series to predict node states and make function
c   evaluations and return predicted final conditions x(tf)
c
      call taylor (x,v,n,m,t,tf,h,f,xf,vf,work,deriv)
c
c...fill the matrices g and b with the proper coefficients so that
c   the interpolation of node points during starting may be done
c   relative to the initial conditions with the back differences
c   formed at tmax.  the initial conditions are assumed to be at
c   t = tf - m/2*h
c
      do 10 i = 1,m
         call ksgco (m,-dfloat(i-1),1.0d+0,gmid,bmid)
         do 10 j = 1,m
            g(j,i) = real(gmid(j),16)
            b(j,i) = real(bmid(j),16)
   10    continue
c
      call ksgco (m,-dfloat(m/2),1.0d+0,gmid,bmid)
c
      do 20 i = 1,m
         im1 = i-1
         im2 = im1*im1
         nmm3 = nmm*(nmm-im1)
         do 20 j = 1,m
            g(j,i) = real(nmm,16)*real(gmid(j),16)-real(im1,16)*g(j,i)
            b(j,i) = real(nmm3,16)*real(gmid(j),16)-real(nmm2,16)*
     .            real(bmid(j),16)+im2*b(j,i)
   20 continue
c
c...begin self-starter loop
c
      nloop = 1
c
c...save last values of final state and velocity
c
   30 do 40 i = 1,3
         xfs(i) = xf(i)
         vfs(i) = vf(i)
   40 continue
c
c...back difference function evaluations
c
      call bckdif (n,m,f)
c
c...compute new node states and function evaluations
c
      do 70 i = 1,m
         j = m+1-i
         t = tf-(m-i)*h
c
         do 60 k = 1,n
            sum1 = 0.0d+0
            sum2 = 0.0d+0
c
            do 50 l = 1,m
               sum1 = sum1+g(m+1-l,j)*f(k,m+1-l)
               sum2 = sum2+b(m+1-l,j)*f(k,m+1-l)
   50       continue
c
            vf(k) = v(k)+h*sum1
            xf(k) = x(k)+(i-(m+1)/2)*h*real(v(k),16)+h*h*sum2
   60    continue
c
         call deriv (t,xf,work(1,j))
c
   70 continue
c
c...move new function evaluations into table
c
      do 80 j = 1,m
         do 80 i = 1,n
            f(i,j) = work(i,j)
   80 continue
c
c...calculate anorm, the l2 relative norm of the difference of two
c   consecutive values of xf and vf  (x and v at t=tf)
c
      anorm = 0.0d+0
      do 90 i = 1,3
         anorm = anorm+((xf(i)-xfs(i))/xmag)**2+((vf(i)-vfs(i))/vmag)**2
   90 continue
      anorm = sqrt(anorm)
c
c...check for convergence
c
      if (anorm.le.alim(1)) go to 110
      nloop = nloop+1
      if (nloop.ge.20) go to 100
      go to 30
c
c...maximum number of allowable loops has been reached
c
  100 if (anorm.le.alim(2)) go to 110
      iflag = 3
      alim(3) = anorm
      return
c
c...starter converged to acceptable tolerance
c
  110 iflag = 2
      alim(3) = anorm
      call bckdif (n,m,f)
      return
c
c.....end sgstrt
      end
