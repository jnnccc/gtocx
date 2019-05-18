program statistics
use module_mod
implicit none

real(dp) :: x(6), x0(6), x00(6), x1(6), t0, t1
integer*8 :: id, i
CHARACTER *80 arg1
CALL GETARG(1,arg1)
read(arg1,*) t0

OPEN(fid1,FILE='output/statistics.0')
call read_stars
do i=1,n_stars
    id=i-1
    call star_state(id, t0, x0)
    write(fid1,'(6e22.9)') x0
enddo
close (fid1)

end program statistics
