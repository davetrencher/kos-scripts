// https://www.instructables.com/Calculating-a-Hohmann-Transfer/
RUNPATH("/lib/calculations").

SET target TO BODY("Minmus").

SET r1 TO calculate_orbit_radius(SHIP:ORBIT).
SET r2 TO calculate_orbit_radius(target:ORBIT).

SET semimajoraxis_transfer_orbit TO ( r2 + r1 ) / 2.

SET transfer_orbit_period TO calculate_orbit_period(semimajoraxis_transfer_orbit,SHIP:BODY:MU).

SET v1 TO SHIP:ORBIT:VELOCITY.
SET v2 TO target:ORBIT:VELOCITY.

SET v_periapsis TO calculate_velocity_transfer(semimajoraxis_transfer_orbit,transfer_orbit_period,r1).
//SET deltav_to_reach_target TO ( v_periapsis:MAG - v1 ).
//
//SET v_apoapsis TO calculate_velocity_transfer(semimajoraxis_transfer_orbit,transfer_orbit_period,r2).
//SET deltav_to_circularise_at_target TO v_apoapsis:MAG - v2.
//
//SET transfer_time TO transfer_orbit_period / 2.
//
//SET phase_angle TO ( 360 / ( target:ORBIT:PERIOD / transfer_orbit_period ) ).

CLEARSCREEN.

//PRINT "Phase Angle: " +phase_angle.
//PRINT "Transfer_time: " +transfer_time.
//PRINT "Deltav_to_reach_target: " +deltav_to_reach_target.
//PRINT "Current Phase Angle: " +calculate_phase_angle(target).

PRINT "Kerbin Velocity " + SHIP:BODY:
PRINT "v_periapsis: " +v_periapsis.
PRINT "v1: " +v1.
PRINT "v2: " +v2.