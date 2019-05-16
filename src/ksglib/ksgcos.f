      subroutine ksgcos (m,hi,h,g1,g2)
c
c...purpose:  compute integration coefficients (using single
c             precision where accuracy is less critical)
c
c...inputs:
c
c     m     number of coefficients to be generated
c     hi    delta time between last node and time out (tout-tmax)
c     h     step size being used
c
c...outputs:
c
c     g1    coefficients for integrating first order diff. eqn.s
c     g2    coefficients for integrating sencond order diff. eqn.s
c
c         note :  m has to be less than or equal to 17
c
      implicit real *8 (a-h,o-z)
      dimension g1(m),g2(m)
      real*16 g(18),gcon(18),eta,etas,psiim,gamma
c
      data gcon / 1.q+0,.5q+0,.333333333333333333333333333333333333q+0,
     *   .25q+0,.2q+0,.166666666666666666666666666666666667q+0,
     *   .142857142857142857142857142857142857q+0,.125q+0,
     *   .111111111111111111111111111111111111q+0,.1q+0,
     *   .909090909090909090909090909909090909q-1,
     *   .833333333333333333333333333333333333q-1,
     *   .769230769230769230769230769230769231q-1,
     *   .714285714285714285714285714285714285q-1,
     *   .666666666666666666666666666666666667q-1,.0625d+0,
     *   .588235294117647058823529411764705882q-1,
     *   .555555555555555555555555555555555556q-1 /
c
c...initialize
c
      etas = hi/h
c
      do 10 i = 1,m+1
         g(i) = gcon(i)
   10 continue
c
      g1(1) = g(1)
      g2(1) = g(2)
c
c...iterate
c
      j = m + 1
      psiim = etas - 2.0q+0
c
      do 30 i = 2,m
         gamma = (i+psiim)*gcon(i-1)
         eta = etas*gcon(i-1)
         j = j-1
c
         do 20 k = 1,j
            g(k) = gamma*g(k) - eta*g(k+1)
   20    continue
c
         g1(i) = g(1)
         g2(i) = g(2)
   30 continue
c
      return
c
c.....end ksgcos
      end
