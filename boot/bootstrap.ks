WAIT UNTIL SHIP:UNPACKED.
CLEARSCREEN.

PRINT "Hello Dave..".

IF (STATUS = "prelaunch") {
    COPYPATH("0:launch.ks","").
    RUN launch.
}