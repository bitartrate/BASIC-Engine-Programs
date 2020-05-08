10 SCREEN 5:PALETTE 0:COLOR 0,91:FONT 1
20 BG 0 TILES 16,14 SIZE 16,16
50 LOAD PCX "charwalk.pcx" AS SPRITE 0
70 SPRITE 0 SIZE 32,32 KEY 197
80 MOVE SPRITE 0 TO 20,20
90 SPRITE 0 ON 
172 buspeed=4
182 plspeedx=2:plspeedy=2
185 BG 0 WINDOW 0,8,256,216 ON 
186 MOVE BG 0 TO 0,8
187 REM PLAY "cdefg4graaaag4r4aaaag4r4ffffe4erddddc2"
190 CALL main:END
730 PROC main
740 REM XXX: sound
760 DO 
770   tic=0
790   plx=104
800   ply=153
820   pldir=1
830   MOVE SPRITE 0 TO plx,ply
915   SPRITE 0 FLAGS 2
917   fr=FRAME()
920   DO 
930     VSYNC fr+1
935     fr=FRAME()
940     p=PAD(0)
950     REM XXX: pause
960     IF p AND LEFT THEN 
965       pldir=-1
970       SPRITE 0 FLAGS 0
980       IF plx>-8 THEN plx=plx-plspeedx 
985       tic=tic+1
990     ENDIF 
1000     IF p AND RIGHT THEN 
1005       pldir=1
1010       SPRITE 0 FLAGS 2
1020       IF plx<232 THEN plx=plx+plspeedx 
1025       tic=tic+1
1030     ENDIF 
1040     IF (p AND UP ) AND ply>9 THEN ply=ply-plspeedy 
1050     IF (p AND DOWN ) AND ply<212 THEN ply=ply+plspeedy 
1390     MOVE SPRITE 0 TO plx,ply
1400     SPRITE 0 FRAME 0,(tic>>2) AND 3
1420   LOOP UNTIL dead=1
1430 LOOP 
