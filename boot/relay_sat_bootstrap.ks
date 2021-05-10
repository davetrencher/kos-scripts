WAIT UNTIL SHIP:UNPACKED.

RUNPATH("/lib/constants").
RUNPATH("/lib/calculations").
RUNPATH("/lib/craft_info").
RUNPATH("/lib/craft_functions").

deploy_solar_panels().

//set apoapsis to keostationary
SET required_periapsis to ALTITUDE_KEOSTATIONARY - ALTITUDE - ALTITUDE_KEOSTATIONARY.

//change method to pass in required circularisation height or use apoapsis if not defined.
SET required_delta_v to calculate_delta_v_to_circularise_apoapsis().
SET isp to get_total_vacuum_isp().
SET burn_time to calculate_burn_time(required_delta_v, isp).

//maybe don't do the above and just burn until required apoapsis/periapsis has been reached.

SET heading TO HEADING(90, 0).
SET throttle TO 1.
STAGE.
