CREATE VIEW driver_career_summary AS
SELECT
	d.driver_id,
    CONCAT(d.forename, ' ', d.surname) AS driver_name,
    COUNT(*) AS total_races,
    SUM(CASE WHEN res.positionOrder = 1 THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN res.positionOrder <= 3 THEN 1 ELSE 0 END) AS podium_finishes,
    SUM(CASE WHEN res.positionOrder = 1 THEN 1 ELSE 0 END)/NULLIF(COUNT(*),0) AS win_rate
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
GROUP BY d.driver_id, driver_name
ORDER BY wins DESC;

SELECT * 
FROM driver_career_summary
ORDER BY wins DESC
LIMIT 20;

CREATE VIEW constructor_career_summary AS
SELECT
	c.constructor_id,
    c.team_name,
    COUNT(*) AS total_races,
    SUM(CASE WHEN res.positionOrder = 1 THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN res.positionOrder <= 3 THEN 1 ELSE 0 END) AS podium_finishes,
    SUM(CASE WHEN res.positionOrder = 1 THEN 1 ELSE 0 END)/NULLIF(COUNT(*),0) AS win_rate
FROM results res
JOIN constructors c ON res.constructor_id = c.constructor_id
GROUP BY c.constructor_id;

SELECT * 
FROM constructor_career_summary
ORDER BY wins DESC
LIMIT 20;

CREATE VIEW race_results_enriched AS
SELECT
	d.driver_id,
	CONCAT(d.forename,' ',d.surname) AS driver_name,
    c.constructor_id,
    c.team_name,
    r.race_id,
	r.race_year,
    r.race_date,
    r.track_name,
    res.positionOrder,
    CASE WHEN positionOrder = 1 THEN 1 ELSE 0 END AS win_flag,
    CASE WHEN positionOrder <= 3 THEN 1 ELSE 0 END AS podium_flag
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
JOIN constructors c ON res.constructor_id = c.constructor_id
JOIN races r ON res.race_id = r.race_id;

SELECT *
FROM race_results_enriched
ORDER BY race_year DESC, race_date DESC, positionOrder
LIMIT 40;

CREATE VIEW driver_season_summary AS
SELECT
	d.driver_id,
    CONCAT(d.forename, ' ', d.surname) AS driver_name,
	r.race_year,
    COUNT(*) AS total_races,
    SUM(CASE WHEN res.positionOrder = 1 THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN res.positionOrder <= 3 THEN 1 ELSE 0 END) AS podium_finishes,
    SUM(CASE WHEN res.positionOrder = 1 THEN 1 ELSE 0 END)/NULLIF(COUNT(*),0) AS win_rate
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
JOIN races r ON res.race_id = r.race_id
GROUP BY d.driver_id, r.race_year
ORDER BY r.race_year DESC, wins DESC;

SELECT *
FROM driver_season_summary
LIMIT 30;