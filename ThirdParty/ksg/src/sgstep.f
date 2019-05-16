      subroutine sgstep (m,h,n,s,sd,x,xd,t,deriv,f,fm,dx)
c
c...purpose:  integrate a system of second order differential equations
c             one step
c
c...inputs:
c
c     m       number of back differences that are retained in f
c     h       step size
c     n       number of second order differential equations
c     s,sd    state at last node
c     t       time to which the solution is to be advanced
c     deriv   routine that evaluates second order derivatives
c     f       back difference table
c     fm      last column of back difference table
c     dx      workspace for derivatives
c             integrated
c
c...outputs:
c
c     s,sd    updated state at last node
c
      implicit real *8 (a-h,o-z)
c
      save g,b
      dimension g(17),b(17),s(n),sd(n),f(n,m),fm(n),dx(n),x(n),xd(n)
c
      external deriv
c
c
c...initialize
c
      h2 = h*h
      hg = h*g(m+1)
      hb = h2*b(m+1)
c
c...predict
c
      do 10 i = 1,n
         x(i) = b(m)*f(i,m)+b(m-1)*f(i,m-1)
         xd(i) = g(m)*f(i,m)+g(m-1)*f(i,m-1)
   10 continue
c
      do 20 j = 3,m
         do 20 i = 1,n
            x(i) = x(i)+b(m+1-j)*f(i,m+1-j)
            xd(i) = xd(i)+g(m+1-j)*f(i,m+1-j)
            f(i,m+1-j) = f(i,m+1-j)+f(i,m+2-j)
   20 continue
c
      do 30 i = 1,n
         s(i) = s(i) + h*(sd(i)+h*x(i))
         sd(i) = sd(i)+h*xd(i)
         fm(i) = fm(i)+f(i,1)
   30 continue
c
c...evaluate at the predicted value
c
      call deriv (t,s,dx)
c
c...take the prediction and correct it
c
      do 40 i = 1,n
         sd(i) = sd(i)+hg*(dx(i)-fm(i))
         s(i) = s(i)+hb*(dx(i)-fm(i))
   40 continue
c
c...evaluate at the corrected value
c
      call deriv (t,s,dx)
c
c...propagate back difference table
c
      do 50 i = 1,n
         fm(i) = dx(i)-f(i,1)
   50 continue
      do 60 j = 2,m
         do 60 i = 1,n
            f(i,m+1-j) = f(i,m+1-j)+fm(i)
   60 continue
c
      return
c
c...entry to set coefficients
c
      entry setco
c
      call ksgco (17,1.0d+0,1.0d+0,g,b)
      return
c
c.....end sgstep
      end
