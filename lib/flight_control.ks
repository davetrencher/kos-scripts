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