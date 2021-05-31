// https://www.instructables.com/Calculating-a-Hohmann-Transfer/
RUNPATH("/lib/calculations").

SET target TO BODY("Minmus").

SET r1 TO calculate_orbit_radius(SHIP:ORBIT).
SET r2 TO calculate_orbit_radius(target:ORBIT).

SET semimajoraxis_transfer_orbit TO ( r2 + r1 ) / 2.

SET transfer_orbit_period TO calculate_orbit_period(semimajoraxis_transfer_orbit,SHIP:BODY:MU).

SET v1 TO SHIP:ORBIT:VELOCITY.
SET v2 TO target:ORBIT:VELOCITY.

//full orbit period
SET transfer_orbit_period TO calculate_orbit_period(semimajoraxis_transfer_orbit,SHIP:BODY:MU).

//distance we need to travel is half the distance
SET transfer_time TO transfer_orbit_period / 2.

SET target_travelled_during_transfer TO ( transfer_time / target:ORBIT:PERIOD ) * 360.
SET required_phase_angle TO 180 - target_travelled_during_transfer.

CLEARSCREEN.

//PRINT "Phase Angle: " +phase_angle.
//PRINT "Transfer_time: " +transfer_time.
//PRINT "Deltav_to_reach_target: " +deltav_to_reach_target.
//PRINT "Current Phase Angle: " +calculate_phase_angle(target).

