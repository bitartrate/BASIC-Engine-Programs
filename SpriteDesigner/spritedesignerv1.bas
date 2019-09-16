100 REM sprite maker
110 GOSUB &instructions
120 WAIT 1000
130 GOSUB &setupscreen
140 GOSUB &sprarray
150 GOSUB &usercursor
160 GOSUB &erase
170 GOTO 150
180 &usercursor
190 REM user cursor
200 GPRINT 195,185,"block ";c;"    ";
210 RECT x,y,x+4,y+5,sprarray(c),sprarray(c)
220 a=PAD(0)
230 a$=INKEY$ 
240 IF a AND 8 THEN 
250   IF y>1 THEN y=y-6:c=c-32:cy=cy-1 
260 ENDIF 
270 IF a AND 2 THEN 
280   IF y<186 THEN y=y+6:c=c+32:cy=cy+1 
290 ENDIF 
300 IF a AND 1 THEN 
310   IF x>1 THEN x=x-6:c=c-1:cx=cx-1 
320 ENDIF 
330 IF a AND 4 THEN 
340   IF x<186 THEN x=x+6:c=c+1:cx=cx+1 
350 ENDIF 
360 IF a AND 256 THEN GOSUB &plotpixel
370 IF a AND 512 THEN GOSUB &erasepixel
380 IF a AND 1024 THEN GOSUB &save
390 IF a AND 2048 THEN GOSUB &load
400 IF a$="i" THEN GOSUB &instructions
410 IF a$="q" THEN SCREEN 1:LIST:END
420 IF a$="d" THEN GOSUB &datastatements
430 IF a$="p" THEN 
440   GOSUB &setupscreen
450   GOSUB &sprarray
460 ENDIF 
470 IF a$="3" THEN 
480   IF ccy>140 THEN ccy=140 
490   ccy=ccy+10:ccx=215
500   IF ccy>0 THEN RECT ccx,ccy-10,ccx+11,ccy+11,0,-1 
510   GOSUB &choosecolor
520 ENDIF 
530 ENDIF 
540 IF a$="9" THEN 
550   IF ccy<1 THEN ccy=10 
560   RECT ccx,ccy,ccx+11,ccy+11,0,-1
570   ccy=ccy-10:ccx=215
580   GOSUB &choosecolor
590 ENDIF 
600 IF a$="6" THEN colr=POINT(ccx+5,ccy+5)
610 REM base color palette selector
620 IF a$="1" THEN 
630   IF ccya>140 THEN ccya=140 
640   ccya=ccya+10:ccxa=195
650   IF ccya>0 THEN RECT ccxa,ccya-10,ccxa+11,ccya+11,0,-1 
660   GOSUB &choosebasecolor
670 ENDIF 
680 ENDIF 
690 IF a$="7" THEN 
700   IF ccya<1 THEN ccya=10 
710   RECT ccxa,ccya,ccxa+11,ccya+11,0,-1
720   ccya=ccya-10:ccxa=195
730   GOSUB &choosebasecolor
740 ENDIF 
750 IF a$="4" THEN colr=POINT(ccxa+3,ccya+3)
760 RETURN 
770 &erase:
780 WAIT 25
790 PSET cx,cy,165
800 RECT x,y,x+4,y+5,165,165
810 WAIT 25
820 PSET cx,cy,sprarray(c)
830 RECT x,y,x+4,y+5,sprarray(c),sprarray(c)
840 RETURN 
850 &plotpixel
860 PSET cx,cy,colr
870 sprarray(c)=colr
880 RECT x,y,x+4,y+5,colr,colr
890 RETURN 
900 &erasepixel
910 PSET cx,cy,0
920 sprarray(c)=0
930 RECT x,y,x+4,y+5,0,0
940 RETURN 
950 &save
960 WINDOW 29,11,11,5
970 INPUT "SName?";nf$
980 SAVE PCX nf$+".pcx"POS 241,1 SIZE 32,32
990 BORDER 75,75:WAIT 250:BORDER 1,75
1000 PRINT "saved":WAIT 500:CLS:WINDOW OFF 
1010 RETURN 
1020 &load
1030 GOSUB &setupscreen
1040 WINDOW 29,11,11,5
1050 INPUT "LName?";nf$
1060 LOAD PCX nf$+".pcx" AS SPRITE 0 TO 241,1 SIZE 32,32
1070 BORDER 75,75:WAIT 100:BORDER 1,75
1080 PRINT "loaded":WAIT 150:CLS:WINDOW OFF 
1090 x=1:y=1:c=1
1100 FOR arty=1 TO 32
1110   FOR artx=241 TO 272
1120     colr=POINT(artx,arty)
1130     RECT x,y,x+4,y+5,colr,colr
1140     x=x+6
1150     sprarray(c)=colr
1160     c=c+1
1170   NEXT artx
1180   x=1:y=y+6
1190 NEXT arty
1200 c=1:x=1:y=1:cx=241:cy=1:colr=165
1210 RETURN 
1220 &datastatements
1221 WINDOW 29,11,11,5
1222 INPUT "DSName?";nf$
1230 spraxx=0
1240 OPEN nf$+".spr" FOR OUTPUT AS 0
1250 FOR spray=1 TO 64
1260   PRINT #0,spray+5000;" DATA ";
1270   FOR sprax=1 TO 16
1280     spraxx=spraxx+1
1290     IF sprax<=15 THEN PRINT #0,sprarray(spraxx);",";
1300     IF sprax=16 THEN PRINT #0,sprarray(spraxx)
1310   NEXT sprax
1320 NEXT spray
1330 CLOSE 0
1331 BORDER 75,75:WAIT 250:BORDER 1,75
1335 PRINT "saved":WAIT 500:CLS:WINDOW OFF 
1340 RETURN 
1350 &palette
1360 rootpaly=0:rootpalyy=10
1370 FOR pc=0 TO 15
1380   READ rootc
1390   RECT 195,rootpaly,205,rootpalyy,rootc,rootc
1400   rootpaly=rootpaly+10:rootpalyy=rootpalyy+10
1410   DATA 0,16,32,48,64,80,96,112,128,144,160,176,192,208,224,240
1420 NEXT pc
1430 paly=0:palyy=10
1440 FOR pc=0 TO 15
1450   RECT 215,paly,225,palyy,cc,cc
1460   paly=paly+10:palyy=palyy+10
1470   cc=cc+1
1480 NEXT pc
1490 RESTORE 1410
1500 RETURN 
1510 &choosecolor
1520 cc=POINT(ccx+5,ccy+5)
1530 REM GPRINT 0,150,cc
1540 RECT ccx,ccy,ccx+11,ccy+11,153,-1
1550 RECT ccx+1,ccy+1,ccx+8,ccy+8,cc,cc11690 RETURN 
1560 &choosebasecolor
1570 cc=POINT(ccxa+5,ccya+5)
1580 REM GPRINT 0,150,cc
1590 RECT ccxa,ccya,ccxa+11,ccya+11,153,-1
1600 RECT ccxa+1,ccya+1,ccxa+8,ccya+8,cc,cc
1610 LINE 215,160,225,160,0
1620 GOSUB 1430
1630 ccy=0:GOSUB &choosecolor
1640 RETURN 
1650 &setupscreen
1660 SCREEN 4:FONT 2:BORDER 1,75:PALETTE 1
1670 REM vertical
1680 FOR x=0 TO 192 STEP 6
1690   LINE x,1,x,192,76
1700 NEXT x
1710 REM horizonal
1720 FOR y=0 TO 192 STEP 6
1730   LINE 0,y,192,y,76
1740 NEXT y
1750 REM sprite bounding box
1760 RECT 240,0,274,34,3,-1
1770 GOSUB &palette
1780 c=1:x=1:y=1:cx=241:cy=1
1790 ccx=215:ccy=0:ccxa=195:ccya=0:colr=165
1800 GOSUB &choosebasecolor
1810 GOSUB &choosecolor
1820 RETURN 
1830 &sprarray
1840 DIM sprarray(1025)
1850 FOR spray=0 TO 1025
1860   sprarray(spray)=0
1870 NEXT spray
1880 RETURN 
1890 &instructions
1900 SCREEN 2:PALETTE 1:BORDER 75,75
1910 PRINT "Sprite drawing prg Ver. 1.0  09/14/2019"
1920 PRINT "For the BASIC Engine"
1930 PRINT "Firmware rev. 0.88-alpha-386"
1940 PRINT "Kevin Anderson/projektprodukt@yahoo.com"
1950 WINDOW 0,5,50,19
1960 PRINT "Controls:"
1970 PRINT "  Arrow keys/PSX"
1980 PRINT "  z=plot pixel"
1990 PRINT "  x=del pixel"
2000 PRINT "  s=save"
2010 PRINT "  a=load"
2020 PRINT "  p=erase and start over"
2030 PRINT "  d=save sprite as data statements"
2040 PRINT ""
2050 PRINT "Palette picker(turn on NumLock):"
2060 PRINT "Base Color controls:    Sub Color Controls:"
2070 PRINT "7=Up                    9=up"
2080 PRINT "1=Down                  3=down"
2090 PRINT "4=Choose color          6=Choose Color"
2100 PRINT ""
2110 INPUT "press <Enter> to go into program";z$
2120 RETURN 
2130 DATA 
2140 DATA 
