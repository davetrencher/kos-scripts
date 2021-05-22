RUNPATH("/phases/preflight").

RUNPATH("/lib/flight_display").
RUNPATH("/lib/calculations").
RUNPATH("/lib/craft_info").
RUNPATH("/lib/craft_functions").
RUNPATH("/lib/flight_control").

ascent(100000, 0).

deploy_fairing().
WAIT 2.
deploy_solar_panels().
circularise().
