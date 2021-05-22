RUNPATH("/phases/preflight").

RUNPATH("/lib/flight_display").
RUNPATH("/lib/calculations").
RUNPATH("/lib/flight_control").
RUNPATH("/lib/craft_functions").

ascent(100000, 90).

deploy_fairing().
WAIT 2.

deploy_solar_panels().
circularise().