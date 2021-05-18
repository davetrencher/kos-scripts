RUNPATH("/lib/constants").
RUNPATH("/lib/calculations").
RUNPATH("/lib/craft_info").
RUNPATH("/lib/craft_functions").
RUNPATH("/lib/flight_control").

SET number_of_satellites TO 3.

RUNPATH("/phases/preflight").
RUNPATH("/phases/ascent").

deploy_fairing().
WAIT 2.
deploy_solar_panels().
circularise().
raise_apoapsis_to_keostationary().

SET resonant_orbit_period TO BODY:ROTATIONPERIOD - (BODY:ROTATIONPERIOD / number_of_satellites).

raise_orbital_period(resonant_orbit_period).

FROM {local sat_num is number_of_satellites.} UNTIL sat_num = 0 STEP {set sat_num to sat_num-1.} DO {
    STAGE.
    WAIT resonant_orbit_period.
}

PRINT "END MISSION!".

function circularise {

    SET delta_v TO calculate_delta_v_to_raise_periapsis(APOAPSIS).
    SET manouver_execute_time TO ETA:APOAPSIS.
    SET manouver_node TO NODE( Timespan(0,0,0,0,manouver_execute_time), 0, 0, delta_v ).

    perform_manouver(manouver_node).
}

function raise_apoapsis_to_keostationary {
    SET delta_v TO calculate_delta_v_to_raise_apoapsis(ALTITUDE_KEOSTATIONARY).
    SET manouver_execute_time TO ETA:PERIAPSIS.
    SET manouver_node TO NODE( Timespan(0,0,0,0,manouver_execute_time), 0, 0, delta_v ).

    perform_manouver(manouver_node).
}

function raise_orbital_period {
    parameter orbital_period_secs.

    SET required_periapsis TO calculate_periapsis_for_orbital_period(ALTITUDE_KEOSTATIONARY,PERIAPSIS,orbital_period_secs, BODY).
    SET delta_v TO calculate_delta_v_to_raise_periapsis(required_periapsis).
    SET manouver_execute_time TO ETA:APOAPSIS.
    SET manouver_node TO NODE( Timespan(0,0,0,0,manouver_execute_time), 0, 0, delta_v ).

    perform_manouver(manouver_node).

}