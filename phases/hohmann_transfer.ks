// https://www.instructables.com/Calculating-a-Hohmann-Transfer/
RUNPATH("/lib/calculations").

SET target TO BODY("Mun").

SET r1 TO calculate_orbit_radius(SHIP:ORBIT).
SET r2 TO calculate_orbit_radius(target:ORBIT).

SET semimajoraxis_transfer_orbit TO ( r2 + r1 ) / 2.

//full orbit period
SET transfer_orbit_period TO calculate_orbit_period(semimajoraxis_transfer_orbit,SHIP:BODY:MU).

//distance we need to travel is half an orbit - maybe Jeb will come back at some point
SET transfer_time TO transfer_orbit_period / 2.

// angle travelled by target during transfer
SET target_theta TO ( transfer_time / target:ORBIT:PERIOD ) * 360.
SET required_phase_angle TO 180 - target_theta.

//work out ejection angle

//work out time until transfer
//work out deltav required for transfer.
SET transfer_deltav TO calculate_velocity_transfer(
//work out any inclination change - later

CLEARSCREEN.

PRINT "r1 " + r1.
PRINT "r2 " + r2.
PRINT "Semi major axis " + semimajoraxis_transfer_orbit.
PRINT "Transfer time " + transfer_time.
PRINT "Required Phase Angle " +required_phase_angle.
