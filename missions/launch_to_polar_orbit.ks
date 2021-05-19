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

function circularise {

    SET delta_v TO calculate_delta_v_to_raise_periapsis(APOAPSIS).
    SET manouver_execute_time TO ETA:APOAPSIS.
    SET manouver_node TO NODE( Timespan(0,0,0,0,manouver_execute_time), 0, 0, delta_v ).

    perform_manouver(manouver_node).
}