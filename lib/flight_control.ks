function useLogisticToKeepWithinMaxEtaApoapsis {
    parameter maxEtaApoapsis.
    parameter L. //max value
    parameter x0. //x mid point
    parameter k. //growth factor (steepness)

    local x is maxEtaApoapsis - ETA:APOAPSIS.
    local midpoint_offset is x - x0.

    if altitude < 1000 or x > 0 {
        return 1.0.
    }

    local y is 1 - (L / (1 + constant:e ^ (k * midpoint_offset))).

    return y.
}

function perform_manouver {
    parameter manouver_node.

    ADD manouver_node.

    SET delta_v to manouver_node:DELTAV:MAG.
    SET burn_duration to calculate_burn_time(delta_v,get_total_vacuum_isp()).
    PRINT "BURN DURATION: " +burn_duration.
    SET time_until_burn TO manouver_node:ETA - ( burn_duration / 2 ).

    SET manouver_node_direction TO manouver_node:deltav:direction.
    LOCK steering TO manouver_node_direction.

    SET burn_throttle TO 0.
    LOCK THROTTLE TO burn_throttle.

    WAIT time_until_burn.

    SET burn_duration_complete to TIME:SECONDS + burn_duration.
    SET deltav0 to manouver_node:deltav.
    SET target_delta_v to SHIP:DELTAV:CURRENT + delta_v.

    UNTIL ( vdot(deltav0,manouver_node:deltav) < 0.5 ) {
        SET burn_throttle to 1.0.
        WAIT 0.001.
    }

    //need to control throttle down.

    SET burn_throttle TO 0.
    REMOVE manouver_node.

}

function ascent {
    parameter targetApoapsis.
    parameter direction.

    SET maxEtaApopsis TO 60.

    LOCK THROTTLE TO useLogisticToKeepWithinMaxEtaApoapsis(maxEtaApopsis,1,0.5,1). //myThrottle.

    WHEN MAXTHRUST = 0 THEN {
        PRINT "Staging".
        STAGE.
        WAIT 1.
        PRESERVE.
    }.

    SET mysteer TO HEADING(90,90).
    LOCK STEERING TO mysteer.
    UNTIL SHIP:APOAPSIS > targetApoapsis {
        IF apoapsis < targetApoapsis {

        //this will circularise but doesn't seem to hit altitude cut off due to rounding.
        //also needs testing at higher level.
            SET pitchPercentage TO (apoapsis / targetApoapsis).
            SET pitch TO ROUND(90 - (90 * pitchPercentage),0).
            PRINT pitch AT(24,5).

        // this is quicker but requires circularisation code as it cuts out when it reaches target apoapsis
            SET altitudePitchPercentage TO (altitude / targetApoapsis).
            SET altitudePitch to ROUND(90 - (90 * altitudePitchPercentage),0).

            SET mysteer TO HEADING(direction, altitudePitch).

        }.
    }.
}

