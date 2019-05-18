      subroutine ut2ksg (x,neqs)
c
c...purpose:  switch integration vector from casmord to KSG format
c
      implicit real *8 (a-h,o-z)
      dimension x(neqs),save(3)
c
      save(1) = x(4)
      save(2) = x(5)
      save(3) = x(6)
c
      do 10 i = 4,neqs
         x(i) = x(i+3)
   10 continue
c
      x(neqs+1) = save(1)
      x(neqs+2) = save(2)
      x(neqs+3) = save(3)
c
      return
c
c.....end ut2ksg
      end
