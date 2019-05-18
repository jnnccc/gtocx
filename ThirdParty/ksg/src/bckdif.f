      subroutine bckdif (n,m,f)
c
c...purpose:  convert a table of function evaluations to back
c             differences
c
      implicit real *8 (a-h,o-z)
      dimension f(n,m)
c
      do 10 i = 2,m
         j = (m+2)-i
         do 10 k = j,m
            do 10 l = 1,n
               f(l,k) = f(l,k-1)-f(l,k)
   10 continue
c
      return
c
c.....end bckdif
      end
