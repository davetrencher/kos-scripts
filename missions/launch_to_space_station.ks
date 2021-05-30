RUNPATH("/lib/constants").
RUNPATH("/lib/calculations").

SET space_station TO Vessel(NAME_SPACE_STATION).

SET target_orbital_period TO space_station:ORBIT:PERIOD.

SET seconds_per_degree TO target_orbital_period / 360.