WAIT UNTIL SHIP:UNPACKED.

IF (STATUS = "prelaunch") {
    loadMainProgram().

    RUNPATH("/lib/craft_functions").

    deploy_fairing().
    WAIT 2.
    deploy_solar_panels().

    // COPYPATH("0:missions/launch_to_standard_orbit.ks","1:launch_mission.ks").

  //  COPYPATH("0:missions/launch_relay_sat_to_keostationary_orbit.ks","1:launch_mission.ks").


 //   RUN launch_mission.
}

function loadMainProgram {
    switch to 1.
    COPYPATH("0:lib","").
    COPYPATH("0:phases","").
}
