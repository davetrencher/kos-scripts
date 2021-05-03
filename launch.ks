//https://ksp-kos.github.io/KOS/tutorials/quickstart.html#step-2-make-the-start-of-the-script
PRINT "hello me".
CLEARSCREEN.

//initial ascent
//roll program
//coast to apoapsis
//circularise


SET targetApoapsis TO 100000.
SET circularise TO true.

function logistic {
	parameter maxEtaApoapsis.
	parameter L. //max value
	parameter x0. //x mid point
	parameter k. //growth factor (steepness)

	local x is maxEtaApoapsis - ETA:APOAPSIS.
	local midpoint_offset is x - x0.

	if altitude < 1000 or x > 0 {
		return 1.0.
	}

	local throttleVal is 1 - (L / (1 + constant:e ^ (k * midpoint_offset))).

	return throttleVal.
}

SET maxEtaApopsis TO 60.
SET myThrottle TO logistic(maxEtaApopsis,1,0.5,1).

// 1 / 1 + E ^ -k
LOCK THROTTLE TO logistic(maxEtaApopsis,1,0.5,1). //myThrottle.

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

CLEARSCREEN.
PRINT "*************************************************" AT (0,0).
PRINT "****          ALTITUDE:                      ****" AT (0,1).
PRINT "****  TIME TO APOAPSIS:                      ****" AT (0,2).
PRINT "****          APOAPSIS:                      ****" AT (0,3).
PRINT "****          PERAPSIS:                      ****" AT (0,4).
PRINT "****             PITCH:                      ****" AT (0,5).
PRINT "*************************************************" AT (0,6).

SET mysteer TO HEADING(90,90).
LOCK STEERING TO mysteer.
UNTIL SHIP:APOAPSIS > targetApoapsis {


	PRINT ROUND(ALTITUDE,0) AT(24,1).
	PRINT ETA:APOAPSIS AT(24,2).
    PRINT ROUND(APOAPSIS,0) AT(24,3).
	PRINT ROUND(PERIAPSIS,0) AT(24,4).

	//gradually curve until apopsis is 100k
	//TODO: keep apoapsis to no more that 60s ahead
	//TODO: keep TWR about 1.5

	IF apoapsis < targetApoapsis {

		SET pitchPercentage TO (apoapsis / targetApoapsis).
		print pitchPercentage AT (0,12).
		SET pitch TO ROUND(90 - (90 * pitchPercentage),0).
		SET mysteer TO HEADING(90, pitch).
		PRINT pitch AT(24,5).
	}.
}.

IF circularise {
	PRINT "CIRCULARISING" AT (0,9).
	UNTIL (PERIAPSIS / APOAPSIS > 0.95) {

		//need to use 0 - prograde angle.
		//vis viva equation????
		//currently shoots out the Ap before Pe gets high enough.
		SET mysteer TO HEADING(90, 0).
	}.
	PRINT "COMPLETE. FLY SAFE." AT (0,10).
}.
