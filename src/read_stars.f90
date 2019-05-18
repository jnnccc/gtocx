subroutine read_stars
use module_mod
implicit none
character*30:: ctemp 
integer*8:: i
OPEN(22,FILE='database/stars.txt',STATUS='old')
READ(22,*)ctemp
do i=1,100001
    stars(i)%id=i-1
    READ(22,'(7x,f10.6,1x,f11.6,1x,f12.6,1x,f12.6,1x,f22.16)',end=112)stars(i)%par(1:5)
    stars(i)%par(2)=stars(i)%par(2)/dpr
    stars(i)%par(3)=stars(i)%par(3)/dpr
    stars(i)%par(4)=stars(i)%par(4)/dpr
enddo
112 continue
close (22)
endsubroutine read_stars
