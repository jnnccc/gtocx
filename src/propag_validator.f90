subroutine propag_validator(t0, x0, t1, x1)
    use module_mod

    implicit none
    real(dp), intent(in) :: t0, t1, x0(6)     ! epoch [yr] and state
    real(dp), intent(out) :: x1(6)  ! state of star

    external FirstOrdEq
    integer IOPT, IOUT, ISTATE, ITASK, ITOL, IWORK(20), LIW, LRW, MF, NEQ
    double precision ATOL, RTOL, RWORK(116)

    NEQ = 6                 ! number of first-order ODE's

    ! initial value
    x1 = x0

    ITOL = 1                ! 1 indicates ATOL is scalar, 2 indicates ATOL is array
    RTOL = 1e-15             ! Relative tolerance

    ATOL = 0            ! Absolute tolerance for each i in Y(i)

    ITASK = 1               ! Indicates that DLSODE is to compute output values of y
    ISTATE = 1              ! ISTATE=1 for first call, ISTATE=2 for subsequent calls
    ! Automatically updated to 2 if DLSODE was successful

    IOPT = 0                ! IOPT=0 for no optional inputs, IOPT=1 for optional inputs
    LRW = 116                ! Length of real work array
    LIW = 20                ! Length of integer work array
    MF = 10                 ! Method flag.  Possible values are:
    ! 10  Nonstiff (Adams) method, no Jacobian used.
    ! 21  Stiff (BDF) method, user-supplied full Jacobian.
    ! 22  Stiff method, internally generated full Jacobian.
    ! 24  Stiff method, user-supplied banded Jacobian.
    ! 25  Stiff method, internally generated banded Jacobian.

    !    20  FORMAT(' At t =', D12.4, '   y =', 6D20.12)

    CALL DLSODE (FirstOrdEq, NEQ, x1, t0, t1, ITOL, RTOL, ATOL, ITASK, ISTATE, IOPT, RWORK, LRW, IWORK, LIW, MF, MF)
    !    WRITE(6, 20)  t1, x1
    IF (ISTATE < 0) THEN
        WRITE(6, 90)  ISTATE
        90 FORMAT(///' Error halt.. ISTATE =', I3)
    END IF

    !    WRITE(6, 60)  IWORK(11), IWORK(12), IWORK(13)
    !    60  FORMAT(/' No. steps =', i4, ',  No. f-s =', i4, ',  No. J-s =', i4)
    !    STOP

endsubroutine propag_validator


SUBROUTINE  FirstOrdEq (NEQ, t, x, xdot)
    ! equation of motion rewritten in first order format
    ! xdot = f(t, x)
    ! where: x = [x, y, z, vx, vy, vz]
    !        xdot = [vx, vy, vz, ax, ay, az]
    use module_mod
    implicit none
    ! Set array Ydot
    INTEGER  NEQ !equals 6
    DOUBLE PRECISION  t, x(6), xdot(6), v, f, r

    xdot(1:3) = x(4:6)

    r = SQRT(x(1)**2 + x(2)**2 + x(3)**2)
    v = 1.d0 / (k(1) + k(2) * r + k(3) * r**2 + k(4) * r**3 + k(5) * r**4 + k(6) * r**5 + k(7) * r**6 + k(8) * r**7 + k(9) * r**8)
    v = v / vel !km/s ---> kpc/myr

    f = v**2 / r

    xdot(4:6) = -x(1:3) * f / r
    RETURN
END
