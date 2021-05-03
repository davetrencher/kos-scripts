WAIT UNTIL SHIP:UNPACKED.
CLEARSCREEN.

PRINT "Hello Dave..".

IF (STATUS = "prelaunch") {
    switch to 1.
    COPYPATH("0:launch.ks","").
    COPYPATH("0:circularise.ks","").

    RUN launch.
}