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
    parameter required_orbital_period.

    SET required_semimajor_axis TO ( ( required_orbital_period * SQRT(BODY:MU)) / ( 2 * CONSTANT:PI ) ) ^ 0.66.
    SET apoapsis_radius TO BODY:RADIUS + APOAPSIS.

    CLEARSCREEN.
    PRINT "Required semimajor axis: " + required_semimajor_axis.
    PRINT "Apoapsis radius: " + apoapsis_radius.

    SET required_orbit_radius TO ( 2 * required_semimajor_axis - apoapsis_radius ) / 2.
    SET required_periapsis TO required_orbit_radius - BODY:RADIUS.

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