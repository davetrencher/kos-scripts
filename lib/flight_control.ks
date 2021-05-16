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