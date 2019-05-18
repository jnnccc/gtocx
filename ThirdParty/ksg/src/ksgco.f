      subroutine ksgco (m,hi,h,g1,g2)
c
c...purpose:  compute integration coefficients
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
      real *16 g(18),gcon(18),eta,etas,psiim,gamma
c
      data gcon / 1.d+0,.5d+0,.3333333333333333333333333333d+0,.25d+0,
     *   .2d+0,.1666666666666666666666666667d+0,
     *   .1428571428571428571428571429d+0,.125d+0,
     *   .1111111111111111111111111111d+0,.1d+0,
     *   .9090909090909090909090909091d-1,.833333333333333333333333333d-
     *   1,.7692307692307692307692307692d-1,
     *   .714285714285714285714285714d-1,.6666666666666666666666666667d-
     *   1,.0625d+0,.5882352941176470588235294118d-1,
     *   .555555555555555555555555556d-1 /
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
            g(k) = gamma*g(k)-eta*g(k+1)
   20    continue
c
         g1(i) = g(1)
         g2(i) = g(2)
   30 continue
c
      return
c
c.....end ksgco
      end
