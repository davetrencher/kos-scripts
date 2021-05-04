CLEARSCREEN.
PRINT "*************************************************" AT (0,0).
PRINT "****          ALTITUDE:                      ****" AT (0,1).
PRINT "****  TIME TO APOAPSIS:                      ****" AT (0,2).
PRINT "****          APOAPSIS:                      ****" AT (0,3).
PRINT "****          PERAPSIS:                      ****" AT (0,4).
PRINT "****             PITCH:                      ****" AT (0,5).
PRINT "*************************************************" AT (0,6).

WHEN ALTITUDE > 0 THEN {
    PRINT ROUND(ALTITUDE,0) AT(24,1).
    PRINT ETA:APOAPSIS AT(24,2).
    PRINT ROUND(APOAPSIS,0) AT(24,3).
    PRINT ROUND(PERIAPSIS,0) AT(24,4).

    PRESERVE.
}