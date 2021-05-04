WAIT UNTIL ship:unpacked.
CLEARSCREEN.

countdown().

FUNCTION countdown {
    PRINT "Countdown:".
    FROM {local Tminus is 10.}
            UNTIL Tminus = 0 STEP {SET Tminus to Tminus - 1.} DO {
        PRINT "T-" + Tminus.
        WAIT 1.
    }
    PRINT "We have lift off!".
}




