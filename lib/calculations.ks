function calculate_delta_v_to_raise_apoapsis {
    parameter required_apoapsis.

    local current_radius is BODY:RADIUS + PERIAPSIS.
    local current_semi_major_axis is SHIP:ORBIT:SEMIMAJORAXIS.
    local current_velocity is calculate_velocity(current_radius, current_semi_major_axis).

    local required_semi_major_axis is calculate_semi_major_axis(required_apoapsis, PERIAPSIS).
    local required_velocity is calculate_velocity(current_radius, required_semi_major_axis).

    return required_velocity - current_velocity.

}

function calculate_delta_v_to_raise_periapsis {
    parameter required_periapsis.

    local current_radius is BODY:RADIUS + APOAPSIS.
    local current_semi_major_axis is SHIP:ORBIT:SEMIMAJORAXIS.
    local current_velocity is calculate_velocity(current_radius, current_semi_major_axis).

    local required_radius is current_radius.
    local required_semi_major_axis is calculate_semi_major_axis(APOAPSIS, required_periapsis).
    local required_velocity is calculate_velocity(required_radius, required_semi_major_axis).

    return required_velocity - current_velocity.

}

//https://www.youtube.com/watch?v=xNiFcI-fcmA
function calculate_periapsis_for_orbital_period {
    parameter current_apoapsis.
    parameter current_periapsis.
    parameter required_orbital_period.
    parameter required_body.

    SET required_semimajor_axis TO ( ( required_orbital_period * SQRT(required_body:MU) ) / ( 2 * CONSTANT:PI ) ) ^ ( 2 / 3 ).
    SET apoapsis_radius TO required_body:RADIUS + current_apoapsis.

    PRINT "MU: " + required_body:MU.
    PRINT "Required Orbital Period: " + required_orbital_period.
    PRINT "Required semimajor axis: " + required_semimajor_axis.

    SET required_orbit_radius TO ( ( 2 * required_semimajor_axis ) - apoapsis_radius ).
    SET required_periapsis TO required_orbit_radius - required_body:RADIUS.

    PRINT "Required orbit radius: " + required_orbit_radius.
    PRINT "Required orbit periapsis: " + required_periapsis.

    return required_periapsis.

}

function calculate_semi_major_axis {
    parameter required_apoapsis.
    parameter required_periapsis.

    return BODY:RADIUS + ( ( required_apoapsis + required_periapsis ) / 2 ).
}

function calculate_velocity {
    parameter radius.
    parameter semi_major_axis.

    local mu is SHIP:ORBIT:BODY:MU.
    local a is semi_major_axis.
    local r is radius.

    //vis viva rocket equation
    local velocity is SQRT( mu * (( 2 / r ) - (1 / a ))).

    return velocity.

}

function calculate_burn_time {
    parameter delta_v.
    parameter isp.

    local F is SHIP:AVAILABLETHRUST.
    local wet_mass is SHIP:WETMASS.
    local dry_mass is SHIP:DRYMASS.
    local flow_rate is F / isp.

    //rocket equation
    local burn_time is (wet_mass - dry_mass) / flow_rate.

    return burn_time.

}

function calculate_phase_angle {
    parameter target.

    SET angle1 TO ORBIT:LAN + ORBIT:ARGUMENTOFPERIAPSIS + ORBIT:TRUEANOMALY.
    SET angle2 TO TARGET:ORBIT:LAN + TARGET:ORBIT:ARGUMENTOFPERIAPSIS + TARGET:ORBIT:TRUEANOMALY.

    SET angle3 TO angle2 - angle1.

    SET angle3 TO angle3 - 360 * floor(angle3/360).

    return angle3.
}

function calculate_orbit_radius {
    parameter orbit.

    return ( orbit:APOAPSIS + orbit:PERIAPSIS ) + orbit:BODY:RADIUS.
}

function calculate_orbit_period {
    parameter semimajoraxis.
    parameter mu.

    return SQRT( ( 4 * ( CONSTANT:PI ^ 2 ) ) * ( semimajoraxis ^ 3 ) / mu ).

}

function calculate_velocity_transfer {
    parameter semimajoraxis_transfer_orbit.
    parameter transfer_orbit_period.
    parameter r.

    return ( ( 2 * CONSTANT:PI ) * semimajoraxis_transfer_orbit / transfer_orbit_period ) * SQRT( ( ( 2 * semimajoraxis_transfer_orbit ) / r ) - 1).
}