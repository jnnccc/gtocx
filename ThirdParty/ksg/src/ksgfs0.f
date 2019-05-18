      subroutine ksgfs0 (h,steps,t,ts,s,sd,f,n,m,iflag)
c
c...purpose:  restart integrator using previously generated back
c             differences
c
      implicit real*8 (a-h, o-z)
      dimension s(n),sd(n),f(n,m)
c
      iflag = 1
      read (14,err=10,end=10) hsaved,tf,ts
      read (14,err=10,end=10) s,sd
      read (14,err=10,end=10) f
      if (hsaved.ne.h) go to 10
      rewind 14
      ts = ts-tf
      steps = ts/h
      iflag = 2
      t = 0.0d+0
      call remark ('  restarted ksgfs using file restrt     ')
      return
c
c...error in restarting integrator
c
c   10 call abort ('  error in restarting ksgfs integrator  ')
   10  call abort
      return
c
c.....end ksgfs0
      end
