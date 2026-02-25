-- Purpose: exploratory queries used to understand F1 dataset --

-- Race wins for each year at every track --
SELECT
    r.race_year,
    r.track_name,
    r.race_date,
    CONCAT(d.forename, ' ', d.surname) AS driver_fullname,
    c.team_name
FROM results res
JOIN races r ON r.race_id = res.race_id
JOIN drivers d ON d.driver_id = res.driver_id
JOIN constructors c ON c.constructor_id = res.constructor_id
WHERE res.positionOrder = 1
ORDER BY r.race_date DESC;

-- Wins by driver --
SELECT
	d.driver_id,
	CONCAT(d.forename, ' ', d.surname) AS full_name,
    COUNT(*) AS wins
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
WHERE res.positionOrder = 1
GROUP BY d.driver_id
ORDER BY wins DESC;

-- Wins by team each year --
SELECT
	r.race_year,
    c.team_name,
    COUNT(*) AS wins
FROM results res
JOIN races r ON res.race_id = r.race_id
JOIN constructors c ON res.constructor_id = c.constructor_id
WHERE res.positionOrder = 1
GROUP BY c.team_name, r.race_year
ORDER BY r.race_year DESC, wins DESC;

-- Win by drivers each year --
SELECT
	r.race_year,
    CONCAT(d.forename, ' ', d.surname) AS full_name,
    COUNT(*) AS wins
FROM results res
JOIN races r ON res.race_id = r.race_id
JOIN drivers d ON res.driver_id = d.driver_id
WHERE res.positionOrder = 1
GROUP BY d.driver_id, r.race_year
ORDER BY r.race_year DESC, wins DESC;

-- Podiums by driver(career) --
SELECT
	d.driver_id,
    CONCAT(d.forename, ' ', d.surname) AS full_name,
    COUNT(*) AS podium_finish
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
WHERE res.positionOrder <= 3
GROUP BY d.driver_id, full_name
ORDER BY podium_finish DESC;

-- Win rate by driver (career) --
SELECT
	d.driver_id,
    CONCAT(d.forename, ' ', d.surname) AS full_name,
    SUM(CASE WHEN positionOrder = 1 THEN 1 ELSE 0 END) AS wins,
    COUNT(*) AS total_races,
    SUM(CASE WHEN positionOrder = 1 THEN 1 ELSE 0 END)/NULLIF(COUNT(*),0) AS win_rate
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
GROUP BY d.driver_id, full_name
HAVING COUNT(*) >= 50
ORDER BY wins DESC, win_rate DESC;

-- Constructor win rate (career) --
SELECT
	c.constructor_id,
    c.team_name,
    SUM(CASE WHEN positionOrder = 1 THEN 1 ELSE 0 END) AS wins,
    COUNT(*) AS total_races,
    SUM(CASE WHEN positionOrder = 1 THEN 1 ELSE 0 END)/NULLIF(COUNT(*),0) AS win_rate
FROM results res
JOIN constructors c ON res.constructor_id = c.constructor_id
GROUP BY c.constructor_id
HAVING COUNT(*) >= 50
ORDER BY wins DESC, win_rate DESC;