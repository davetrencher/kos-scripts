RUNPATH("/lib/constants").
RUNPATH("/lib/calculations").
RUNPATH("/lib/craft_info").
RUNPATH("/lib/craft_functions").
RUNPATH("/lib/flight_control").

RUNPATH("/phases/preflight").
RUNPATH("/phases/ascent").

deploy_fairing().
WAIT 2.
deploy_solar_panels().
circularise().
raise_apoapsis_to_keostationary().

//circularise orbit.
//wait until periapsis
//raise_apoapsis_to_keostationary().
//wait until apoapsis.
//raise_periapsis_to_4_hour_orbital_period().
//deploy_relay_sat().
//warp_to_next_apoapsis().
//deploy_relay_sat().
//warp_to_next_apoapsis().
//deploy_relay_sat().

function circularise {

    SET delta_v TO calculate_delta_v_to_raise_periapsis(APOAPSIS).
    SET manouver_execute_time TO ETA:APOAPSIS.
    SET manouver_node TO NODE( Timespan(0,0,0,0,manouver_execute_time), 0, 0, delta_v ).

    perform_manouver(manouver_node).
}

function raise_apoapsis_to_keostationary {
    CLEARSCREEN.
    SET delta_v TO calculate_delta_v_to_raise_apoapsis(ALTITUDE_KEOSTATIONARY).
    SET manouver_execute_time TO ETA:PERIAPSIS.
    SET manouver_node TO NODE( Timespan(0,0,0,0,manouver_execute_time), 0, 0, delta_v ).

    perform_manouver(manouver_node).
}

function warp_to_next_apoapsis {
    REMOVE manouver_node.
}