INSERT IGNORE INTO drivers
SELECT
CAST(driver_id AS UNSIGNED),
forename,
surname,
nationality
FROM drivers_staging;

INSERT INTO results
SELECT
CAST(result_id AS UNSIGNED),
CAST(race_id AS UNSIGNED),
CAST(driver_id AS UNSIGNED),
CAST(constructor_id AS UNSIGNED),

NULLIF(grid,''),
NULLIF(position,''),
NULLIF(positionOrder,''),

position_des,

NULLIF(points,''),
NULLIF(statusId,'')

FROM results_staging;