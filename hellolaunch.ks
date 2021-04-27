//https://ksp-kos.github.io/KOS/tutorials/quickstart.html#step-2-make-the-start-of-the-script

CLEARSCREEN.

LOCK THROTTLE TO 1.0.

PRINT "Counting down:".
FROM {local countdown is 10.} 
UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
	PRINT "..." + countdown.
	WAIT 1.
}

WHEN MAXTHRUST = 0 THEN {
	PRINT "Staging".
	STAGE.  
	PRESERVE.
}.

SET MYSTEER TO HEADING(90,90).
LOCK STEERING TO MYSTEER.
UNTIL SHIP:APOAPSIS > 100000 {
	
	IF SHIP:VELOCITY:SURFACE:MAG < 100 {
	
		SET MYSTEER TO HEADING(90,90).
	
	} ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 100 AND SHIP:VELOCITY:SURFACE:MAG < 200 {
		SET MYSTEER TO HEADING(90,80).
		PRINT "Pitching TO 80n degrees" AT (0,15).
		PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).
	}.	
	
}.
