RUNPATH("/lib/constants").
RUNPATH("/lib/calculations").
RUNPATH("/lib/craft_info").
RUNPATH("/lib/craft_functions").

RUNPATH("/phases/preflight").
RUNPATH("/phases/ascent").

deploy_fairing().
WAIT 2.
deploy_solar_panels().

raise_apoapsis_to_keostationary().
//raise_periapsis_to_4_hour_orbital_period().
//deploy_relay_sat().
//warp_to_next_apoapsis().
//deploy_relay_sat().
//warp_to_next_apoapsis().
//deploy_relay_sat().

function raise_apoapsis_to_keostationary {
    CLEARSCREEN.
    SET delta_v TO calculate_delta_v_to_raise_apoapsis(ALTITUDE_KEOSTATIONARY).
    SET manouver_execute_time TO ETA:APOAPSIS.
    PRINT "Delta V               " +delta_v.
    PRINT "Manouver Execute Time " +manouver_execute_time.
    SET manouver_node TO NODE( Timespan(0,0,0,0,manouver_execute_time), 0, delta_v, 0 ).
    ADD manouver_node.

    SET burn_duration to calculate_burn_time(delta_v,get_total_vacuum_isp()).
    SET time_to_burn TO ( manouver_node:TIME - (burn_duration / 2) ).

    SET np TO manouver_node:deltav.
    lock steering to np.

    PRINT "Burn Start ".
    LOCK THROTTLE TO 1.0.

    SET burn_duration_complete to TIME:SECONDS + burn_duration.
    WHEN TIME:SECONDS > burn_duration_complete THEN {
        LOCK THROTTLE TO 0.
        PRINT "Burn Complete".
    }
    REMOVE manouver_node.
}

function raise_periapsis_to_4_hour_orbital_period {

}

function deploy_relay_sat {
    STAGE.
    WAIT 2.
    PRINT "Deployed Relay Sat".
}

function warp_to_next_apoapsis {
    REMOVE manouver_node.
}