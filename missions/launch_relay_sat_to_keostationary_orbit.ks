RUNPATH("/lib/constants").
RUNPATH("/lib/calculations").
RUNPATH("/lib/craft_info").
RUNPATH("/lib/craft_functions").

RUNPATH("/phases/preflight").
RUNPATH("/phases/ascent").

deploy_fairing().
WAIT 2.
deploy_solar_panels().
circularise().

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

function raise_apoapsis_to_keostationary {
    CLEARSCREEN.
    SET delta_v TO calculate_delta_v_to_raise_apoapsis(ALTITUDE_KEOSTATIONARY).
    SET manouver_execute_time TO ETA:APOAPSIS.
    PRINT "Delta V               " +delta_v.
    PRINT "ETA_APOAPSIS          " +ETA:APOAPSIS.
    PRINT "Manouver Execute Time " +manouver_execute_time.
    SET manouver_node TO NODE( Timespan(0,0,0,0,manouver_execute_time), 0, delta_v, 0 ).
    ADD manouver_node.

    SET burn_duration to calculate_burn_time(delta_v,get_total_vacuum_isp()).
    SET time_until_burn TO manouver_node:ETA - ( burn_duration / 2 ).

    SET manouver_node_direction TO manouver_node:deltav:direction.
    lock steering to manouver_node_direction.

    PRINT "Time until burn: " + time_until_burn.

    set burn_throttle to 0.
    LOCK THROTTLE TO burn_throttle.

    WAIT time_until_burn.

    PRINT "Burn Start:".
    SET burn_duration_complete to TIME:SECONDS + burn_duration.
    SET burn_throttle to 1.0.
    WHEN TIME:SECONDS > burn_duration_complete THEN {
        set burn_throttle to 0.
        PRINT "Throttle down to 0".
    }

    PRINT "Removing Manouver Node".
    REMOVE manouver_node.
}

function circularise {

    SET delta_v TO calculate_delta_v_to_raise_periapsis(APOAPSIS).
    SET manouver_execute_time TO ETA:APOAPSIS.
    PRINT "Delta V               " +delta_v.
    PRINT "ETA_APOAPSIS          " +ETA:APOAPSIS.
    PRINT "Manouver Execute Time " +manouver_execute_time.
    SET manouver_node TO NODE( Timespan(0,0,0,0,manouver_execute_time), 0, 0, delta_v ).
    ADD manouver_node.

    SET burn_duration to calculate_burn_time(delta_v,get_total_vacuum_isp()).
    SET time_until_burn TO manouver_node:ETA - ( burn_duration / 2 ).

    SET manouver_node_direction TO manouver_node:deltav:direction.
    lock steering to manouver_node_direction.

    PRINT "Time until burn: " + time_until_burn.

    set burn_throttle to 0.
    LOCK THROTTLE TO burn_throttle.

    WAIT time_until_burn.

    PRINT "Burn Start:".
    SET burn_duration_complete to TIME:SECONDS + burn_duration.
    SET deltav0 to manouver_node:deltav.
    SET target_delta_v to SHIP:DELTAV:CURRENT + delta_v.

    clearscreen.
    PRINT "current delta v: "  +SHIP:DELTAV:CURRENT.
    PRINT "target delta_v: " +target_delta_v.
    PRINT "node deltav " +deltav0 AT(0,20).
    PRINT "node deltav:mag " +manouver_node:deltav:mag AT(0,21).
    PRINT "should break: " +manouver_node:deltav:mag > 0.1 AT(0,22).


    UNTIL manouver_node:deltav:mag < 0.1 {
        SET burn_throttle to 1.0.
        PRINT "node deltav " +manouver_node:deltav AT(0,20).
        PRINT "node deltav:mag " +manouver_node:deltav:mag AT(0,21).
        PRINT "should break: " +manouver_node:deltav:mag < 0.1 AT(0,22).
        PRINT "should break 2: " +vdot(deltav0,manouver_node:deltav) < 0.1 AT(0,23).
        WAIT 0.001.
    }

    set burn_throttle to 0.
    PRINT "Throttle down to 0".
    PRINT "Removing Manouver Node".
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