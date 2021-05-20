CLEARSCREEN.
PRINT "*************************************************" AT (0,0).
PRINT "****          ALTITUDE:                      ****" AT (0,1).
PRINT "****          APOAPSIS:                      ****" AT (0,2).
PRINT "****          PERAPSIS:                      ****" AT (0,3).
PRINT "****          LATITUDE:                      ****" AT (0,4).
PRINT "****         LONGITUDE:                      ****" AT (0,5).
PRINT "****        OFFSET LAT:                      ****" AT (0,6).
PRINT "****        OFFSET LNG:                      ****" AT (0,7).
PRINT "****             PITCH:                      ****" AT (0,8).
PRINT "****           HEADING:                      ****" AT (0,9).
PRINT "*************************************************" AT (0,10).

SET KSC_LAT TO   -0.0972077224633351.
SET KSC_LNG TO -74.55767878224131.

WHEN ALTITUDE > 10 THEN {
    PRINT ROUND(ALTITUDE,0) AT(24,1).
    PRINT ROUND(APOAPSIS,0) AT(24,2).
    PRINT ROUND(PERIAPSIS,0) AT(24,3).

    SET latlng TO SHIP:GEOPOSITION.
    SET OFFSET_LAT TO latlng:LAT - KSC_LAT.
    SET OFFSET_LNG TO latlng:LNG - KSC_LNG.

    PRINT latlng:LAT AT(24,4).
    PRINT latlng:LNG AT(24,5).
    PRINT OFFSET_LAT AT(24,6).
    PRINT OFFSET_LNG AT(24,7).
    PRINT ROUND(SHIP:DIRECTION:PITCH,0) AT(24,8).
    PRINT ROUND(SHIP:HEADING,0) AT(24,9).

    PRESERVE.
}

SAS OFF.
RCS OFF.

SET mysteer TO HEADING(270,0).
LOCK STEERING TO mysteer.
SET mythrottle TO 0.
LOCK THROTTLE TO mythrottle.

WAIT UNTIL ( ( OFFSET_LNG > -20.0 ) AND ( OFFSET_LNG < -15.0 ) ) OR ( PERIAPSIS < 0.0 ).

UNTIL ( PERIAPSIS < ( 1 - ( 600000 * 0.8 ) ) ) {
    SET mysteer TO HEADING(270,0).
    SET mythrottle TO 1.0.
}
SET mythrottle TO 0.

UNTIL ( ALT:RADAR < 3000 ) {
    SET mysteer TO HEADING(270,45).
}

CHUTES ON.

//need to check until stage has paracutes.
UNTIL SHIP:STAGENUM = 0 {
    STAGE.
    WAIT 0.1.
}

PRINT "THANK YOU FOR FLYING WITH US!".

