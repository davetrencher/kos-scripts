WAIT UNTIL SHIP:UNPACKED.

IF (STATUS = "prelaunch") {
    loadMainProgram().

    PRINT "Using standard mission profile".
    COPYPATH("0:missions/launch_to_standard_orbit.ks","1:launch_mission.ks").

    RUN launch_mission.
}

function loadMainProgram {
    switch to 1.
    COPYPATH("0:lib","").
    COPYPATH("0:preflight.ks","").
    COPYPATH("0:ascent.ks","").
}
