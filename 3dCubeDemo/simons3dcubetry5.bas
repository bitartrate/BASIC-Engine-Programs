100 'simons3dcubetry5.bas
110 SCREEN 4
120 INPUT "1=no buffer, 2=vsync, 3=fake tripple buffer";choice$
125 vf=1
130 CLS 
140 GPRINT 0,0,"60288 - free mem ";FREE();" ";"program size=";60288-FREE();
150 nppp=0
160 rx=-0.1:REM rotation angle x
170 DIM x(9):DIM y(9):DIM z(9)
180 DIM vx(5150):DIM vy(5150)
190 'colour0,0 background/border color
200 l=80:fs=200:l=l/2
210 REM*** edges ***
220 FOR npp=1 TO 625
230   'l=l+1:IF l=60 THEN l=20 'get bigger
240   x(1)=-l:y(1)=-l:z(1)=-l
250   x(2)=-l:y(2)=l:z(2)=-l
260   x(3)=l:y(3)=l:z(3)=-l
270   x(4)=l:y(4)=-l:z(4)=-l
280   x(5)=-l:y(5)=-l:z(5)=l
290   x(6)=-l:y(6)=l:z(6)=l
300   x(7)=l:y(7)=l:z(7)=l
310   x(8)=l:y(8)=-l:z(8)=l
320   rx=rx+0.01:c=COS(rx):s=SIN(rx)
330   FOR np=1 TO 8
340     nppp=nppp+1
350     'rot on x axes
360     yt=y(np):y(np)=c*yt-s*z(np):z(np)=s*yt+c*z(np)
370     'rot on y axes
380     xt=x(np):x(np)=c*xt+s*z(np):z(np)=-s*xt+c*z(np)
390     'rot on z axes
400     xt=x(np):x(np)=xt*c-y(np)*s:y(np)=xt*s+y(np)*c
410     REM projections and translations
420     vx(nppp)=160+(x(np)*fs)/(z(np)+fs)
430     vy(nppp)=100+(y(np)*fs)/(z(np)+fs)
440   NEXT np
450   GPRINT 0,40,nppp;
460 NEXT npp
470 REM *** plotting dei vertex ***
480 'hires13,0 pixel/background colors
490 'choice$=INKEY$
500 IF choice$="3" THEN GOTO 840 'fake tripple buffer467 '***************************************
510 '***************************************
520 REM *** plotting linee with vsync***
530 FOR pl=0 TO 624
540   count=count+1
550   pll=pll+8
560   lc=120
570   GPRINT 0,50,count;"        ";"pll ";pll;"   ";
580   GPRINT 0,60,"pl ";pl;"     ";
590   FOR g=1 TO 2
600     IF g=2 THEN lc=0 
610     GPRINT 0,80,"pll*g ";pll;"   ";
620     LINE vx(pll+1),vy(pll+1),vx(pll+2),vy(pll+2),lc:LINE vx(pll+2),vy(pll+2),vx(pll+3),vy(pll+3),lc
630     LINE vx(pll+3),vy(pll+3),vx(pll+4),vy(pll+4),lc:LINE vx(pll+4),vy(pll+4),vx(pll+1),vy(pll+1),lc
640     LINE vx(pll+5),vy(pll+5),vx(pll+6),vy(pll+6),lc:LINE vx(pll+6),vy(pll+6),vx(pll+7),vy(pll+7),lc
650     LINE vx(pll+7),vy(pll+7),vx(pll+8),vy(pll+8),lc:LINE vx(pll+8),vy(pll+8),vx(pll+5),vy(pll+5),lc
660     LINE vx(pll+8),vy(pll+8),vx(pll+5),vy(pll+5),lc:LINE vx(pll+1),vy(pll+1),vx(pll+5),vy(pll+5),lc
670     LINE vx(pll+4),vy(pll+4),vx(pll+8),vy(pll+8),lc:LINE vx(pll+2),vy(pll+2),vx(pll+6),vy(pll+6),lc
680     LINE vx(pll+3),vy(pll+3),vx(pll+7),vy(pll+7),lc
690     'PSET vx(pll+1)-2,vy(pll+1)-2,255
700     'PSET vx(pll+2)-2,vy(pll+2)+2,255
710     IF choice$="2" THEN 
720       IF g=1 THEN f=FRAME():VSYNC f+vf 
730     ENDIF 
731     vf$=INKEY$
732     IF vf$="a" THEN f=FRAME():vf=vf+1 
733     IF vf$="z" THEN f=FRAME():vf=vf-1 
734     'GPRINT 0,195,"vsync vf=";vf;
740   NEXT g
750   'END
760 NEXT pl
770 GPRINT 0,10,"free mem after run ";FREE();
780 GPRINT 0,170,"system free bits 482304";
790 GPRINT 0,180,"after arrays loaded 14106 bits left";
800 GPRINT 0,190,"arrays are about 468198bits plus program";
810 pll=0
820 GOTO 530
830 '**********************************
840 REM *** plotting linee with fake tripple buffer***
850 FOR pl=0 TO 624
860   count=count+1
870   pll=pll+8
880   lc=120
890   GPRINT 0,50,count;"        ";"pll ";pll;"   ";
900   GPRINT 0,60,"pl ";pl;"     ";
910   FOR g=1 TO 3'fake tripple buffer
920     GPRINT 0,80,"pll*g ";pll;"   ";
930     LINE vx(pll+1),vy(pll+1),vx(pll+2),vy(pll+2),lc:LINE vx(pll+2),vy(pll+2),vx(pll+3),vy(pll+3),lc
940     LINE vx(pll+3),vy(pll+3),vx(pll+4),vy(pll+4),lc:LINE vx(pll+4),vy(pll+4),vx(pll+1),vy(pll+1),lc
950     LINE vx(pll+5),vy(pll+5),vx(pll+6),vy(pll+6),lc:LINE vx(pll+6),vy(pll+6),vx(pll+7),vy(pll+7),lc
960     LINE vx(pll+7),vy(pll+7),vx(pll+8),vy(pll+8),lc:LINE vx(pll+8),vy(pll+8),vx(pll+5),vy(pll+5),lc
970     LINE vx(pll+8),vy(pll+8),vx(pll+5),vy(pll+5),lc:LINE vx(pll+1),vy(pll+1),vx(pll+5),vy(pll+5),lc
980     LINE vx(pll+4),vy(pll+4),vx(pll+8),vy(pll+8),lc:LINE vx(pll+2),vy(pll+2),vx(pll+6),vy(pll+6),lc
990     LINE vx(pll+3),vy(pll+3),vx(pll+7),vy(pll+7),lc
1000     IF g=2 THEN pll=pll-16 ELSE pll=pll+8 
1010     IF g=2 THEN lc=0 
1020   NEXT g
1030   'END
1040 NEXT pl
1050 GPRINT 0,10,"free mem after run ";FREE();
1060 GPRINT 0,170,"system free bits 482304";
1070 GPRINT 0,180,"after arrays loaded 14106 bits left";
1080 GPRINT 0,190,"arrays are about 468198bits plus program";
1090 pll=0
1100 GOTO 840
