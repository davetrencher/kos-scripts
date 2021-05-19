WAIT UNTIL SHIP:UNPACKED.

loadMainProgram().

IF (STATUS = "prelaunch") {

    COPYPATH("0:missions/launch_to_polar_orbit.ks","1:launch_mission.ks").
    RUN launch_mission.
}

function loadMainProgram {
    switch to 1.
    COPYPATH("0:lib","").
    COPYPATH("0:phases","").
}
