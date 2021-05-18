WAIT UNTIL SHIP:UNPACKED.

loadMainProgram().

RUNPATH("/lib/constants").
RUNPATH("/lib/calculations").
RUNPATH("/lib/craft_info").
RUNPATH("/lib/craft_functions").

deploy_solar_panels().

COPYPATH("0:missions/keo_sat.ks","").

RUNPATH("keo_sat").

function loadMainProgram {
    switch to 1.
    COPYPATH("0:lib","").
    COPYPATH("0:missions","").
}