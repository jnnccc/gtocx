      subroutine ksgdr (n,m,tin,tout,h,x,xd,deriv,tsave,tmin,tmax,steps,
     *                  ts,s,sd,work,f,iflag,alim,nloop)
c
c...purpose:  driver for ksgfs integrator
c
c...variables:
c
c     n       number of second order differential equations
c     m       number of nodes to be used in back difference table
c     h       step size
c     tin     on input, the initial time.  on output, tin = tout
c     tout    time to which x and xd are to be advanced
c     x,xd    position and velocity vectors, each of length n.
c             (x and xd are assumed to form a continuous vector)
c     deriv   name of routine that returns second derivatives
c     tsave   initial time of integration
c     tmin    lower limit for interpolation (if time is less than tmin,
c             then solution cannot be interpolated and an error results)
c             One case is that the observations are not in proper order
c             chronologically.
c     tmax    upper limit for interpolation (solution is advanced to
c             keep interpolation between tmin and tmax)
c     steps   number of integrations steps past tsave
c     ts      time of furthest integration
c     s,sd    vectors of length n for the storage of the state and
c             velocity at time ts. (assumed to form a continuous vector)
c     work    workspace of length n*m
c     f       back difference table (dimension n x m)
c     iflag   flag indicating status of integration
c             = 1  start
c             =-1  restart
c             = 2  normal integration mode
c             = 3  starter did not converge to required tolerance
c             = 4  tout is not between tmax and tmin and is in
c                  wrong direction of h
c     alim    convergence criterion for starting.  alim(1) is the
c             maximum desired value of anorm, the l2 relative norm
c             between two consecutive values of postion and velocity
c             during starting.  if convergence below alim(1) is not
c             attained after 20 iterations, the solution is still
c             accepted if anorm is less than alim(2).  upon return from
c             sgstrt, alim(3) contains the final value of anorm even if
c             the starter does not converge.
c     nloop   number of iterations starter needed to attain convergence
c             integrated along with position and velocity
c
      implicit none
      integer :: n, m, steps, iflag, nloop
      real(8) :: h, tin, tout, x, xd, deriv, tsave, tmin, tmax, ts, s, sd, work, f, alim
      dimension x(n),xd(n),s(n),sd(n),work(n,m),f(n,m),alim(3)
      
      integer :: ncall, nsteps
      real(8) :: tato, tito
c
c
      external deriv
c
c...check if starting is required
c
      if (iabs(iflag).eq.1) go to 20
c
c...check to see if only interpolation is needed
c
   10 tito = tmin-tout
      tato = tout-tmax
      if (tito*tato.gt.0.0d+0) go to 50
c
c...check if tout is in the right direction
c
      if (h*tato.ge.0.0d+0) go to 30
c
c...error;  tout is on wrong side of tmin
c
      iflag = 4
      return
c
c...start/restart integrator
c
   20 steps = m/2
      tsave = tin
      ts = tin
c
c...generate the initial values for the back difference table
c   and advance the solution from t=tin to t=tin+steps*h
c
      if (iflag.eq.-1) call ksgfs0 (h,steps,tsave,ts,s,sd,f,n,m,iflag)
c
      if (iflag.eq.1) call sgstrt (deriv,x,xd,ts,n,m,work,s,sd,alim,
     *                             nloop,h,f,iflag)
c
      if (iflag.ne.2) return
c
c...set integration coefficients
c
      call setco
c
      tmin = ts-h*(m-1)
      tmax = ts-h*(m/2-1)
      go to 10
c
c...integrate past tout
c
   30 ncall = int(tato/h)+1
      nsteps = 0
c
   40 nsteps = nsteps+1
      steps = steps+1.0d+0
      ts = tsave+steps*h
      call sgstep (m,h,n,s,sd,x,xd,ts,deriv,f,f(1,m),work)
      if (nsteps.lt.ncall) go to 40
c
      tmin = ts-h*(m-1)
      tmax = ts-h*(m/2-1)
c
c...interpolate state at t=tout
c
   50 call sgntrp (m,n,s,sd,x,xd,f,ts,tout,h)
      tin = tout
      return
c
c.....end ksgdr
      end
