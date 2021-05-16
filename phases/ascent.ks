CLEARSCREEN.
RUNPATH("/lib/flight_display").
RUNPATH("/lib/flight_control").

SET targetApoapsis TO 100000.
SET maxEtaApopsis TO 60.

LOCK THROTTLE TO useLogisticToKeepWithinMaxEtaApoapsis(maxEtaApopsis,1,0.5,1). //myThrottle.

WHEN MAXTHRUST = 0 THEN {
	PRINT "Staging".
	STAGE.
	WAIT 1.
	PRESERVE.
}.

SET mysteer TO HEADING(90,90).
LOCK STEERING TO mysteer.
UNTIL SHIP:APOAPSIS > targetApoapsis {
	IF apoapsis < targetApoapsis {

		//this will circularise but doesn't seem to hit altitude cut off due to rounding.
		//also needs testing at higher level.
		SET pitchPercentage TO (apoapsis / targetApoapsis).
		SET pitch TO ROUND(90 - (90 * pitchPercentage),0).
		PRINT pitch AT(24,5).

		// this is quicker but requires circularisation code as it cuts out when it reaches target apoapsis
		SET altitudePitchPercentage TO (altitude / targetApoapsis).
		SET altitudePitch to ROUND(90 - (90 * altitudePitchPercentage),0).

		SET mysteer TO HEADING(90, altitudePitch).

	}.
}.