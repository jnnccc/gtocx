      subroutine ksg2ut (x,neqs)
c
c...purpose:  switch integration vector from ksg to casmord format
c
      implicit real *8 (a-h,o-z)
      dimension x(6),save(3)
c
      save(1) = x(neqs+1)
      save(2) = x(neqs+2)
      save(3) = x(neqs+3)
c
      do 10 i = 4,neqs
         j = neqs-i+4
         x(j+3) = x(j)
   10 continue
c
      x(6) = save(3)
      x(5) = save(2)
      x(4) = save(1)
c
      return
c
c.....end ksg2ut
      end
