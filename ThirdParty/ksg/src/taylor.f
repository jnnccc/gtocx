      subroutine taylor (x,xd,n,m,ti,tf,h,f,s,sd,xdd,deriv)
c
c...purpose:  predict state forward and backward from initial time
c             using a second order taylor series
c
      implicit real *8 (a-h,o-z)
      dimension x(n),xd(n),xdd(n),s(n),sd(n),f(n,m)
c
      external deriv
c
c...calculate the acceleraton at ti
c
      call deriv (ti,x,xdd)
c
c...predict s and sd
c
      do 20 i = 1,m
         ts = tf-(m-i)*h
         dt = ts-ti
         dt2 = dt*dt/2.0d+0
c
         do 10 j = 1,n
            s(j) = x(j)+dt*xd(j)+dt2*xdd(j)
            sd(j) = xd(j)+dt*xdd(j)
   10    continue
c
         call deriv (ts,s,f(1,m+1-i))
   20 continue
c
      return
c
c.....end taylor
      end
