      subroutine sgntrp (m,n,s,sd,x,xd,f,ts,tout,h)
c
c...purpose:  return the solution at tout by evaluating the
c             approximating polynomial there
c
c...inputs:
c
c     m        order of interpolation
c     n        number of second order differential equations
c     s,sd     state at t=ts
c     f        back difference table
c     ts       time of last node
c     tout     time at which interpolated state is requested
c     h        step size
c
c...outputs:
c
c     x,xd     state at t=tout
c
      implicit real *8 (a-h,o-z)
      dimension s(n),sd(n),x(n),xd(n),g(16),b(16),f(n,m)
c
      hi = tout-ts
c
c...obtain the interpolating coefficients
c
      call ksgcos (m,hi,h,g,b)
c
c...form the summation of the coefficients and the back differences
c
      do 10 i = 1,n
         x(i)  = b(m)*f(i,m)
         xd(i) = g(m)*f(i,m)
   10 continue
c
      do 30 j = 2,m
         do 20 i = 1,n
            x(i)  = x(i)  + b(m+1-j)*f(i,m+1-j)
            xd(i) = xd(i) + g(m+1-j)*f(i,m+1-j)
   20    continue
   30 continue
c
      do 40 i = 1,n
         x(i)  = s(i) + hi*(sd(i)+hi*x(i))
         xd(i) = sd(i) + hi*xd(i)
   40 continue
c
      return
c
c.....end sgntrp
      end
