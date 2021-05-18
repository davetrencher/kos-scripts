RUNPATH("/lib/constants").

PRINT "Sat online 1".

SET Y TO HEADING(90, 0).
LOCK STEERING TO Y.

PRINT "STEERING LOCKED".

LIST ENGINES in engineList.

FOR engine IN engineList {
    engine:activate().
}

WAIT 5.

PRINT "WAITED".
PRINT PERIAPSIS.
PRINT ALTITUDE_KEOSTATIONARY.

SET burn_throttle TO 0.
LOCK THROTTLE TO burn_throttle.

UNTIL PERIAPSIS > ALTITUDE_KEOSTATIONARY {
    PRINT "BURN".
    SET burn_throttle to 1.0.
    WAIT 0.001.
}
PRINT "BURN END".
SET burn_throttle TO 0.

PRINT "COMPLETE".