subroutine read_stars
use module_mod
implicit none
character*30:: ctemp 
integer*8:: i
OPEN(fid0,FILE='database/stars.txt',STATUS='old')
READ(fid0,*)ctemp
do i=1,n_stars
    stars(i)%id=i-1
    READ(22,'(7x,f10.6,1x,f11.6,1x,f12.6,1x,f12.6,1x,f22.16)',end=112)stars(i)%par(1:5)
    stars(i)%par(2)=stars(i)%par(2)/dpr
    stars(i)%par(3)=stars(i)%par(3)/dpr
    stars(i)%par(4)=stars(i)%par(4)/dpr
enddo
112 continue
close (fid0)
endsubroutine read_stars
