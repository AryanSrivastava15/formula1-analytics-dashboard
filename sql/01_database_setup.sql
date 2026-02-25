CREATE DATABASE f1_db;
USE f1_db;

CREATE TABLE drivers_staging (
driver_id VARCHAR(10),
driverRef VARCHAR(50),
number VARCHAR(10),
code VARCHAR(10),
forename VARCHAR(50),
surname VARCHAR(50),
dob VARCHAR(20),
nationality VARCHAR(50),
url VARCHAR(255)
);

CREATE TABLE drivers(
driver_id INT PRIMARY KEY,
forename VARCHAR(50),
surname VARCHAR(50),
driver_nationality VARCHAR(50)
);

CREATE TABLE constructors(
	constructor_id INT PRIMARY KEY,
    team_name VARCHAR(50),
	team_nationality VARCHAR(50)
);

CREATE TABLE races(
	race_id INT PRIMARY KEY,
    race_year INT,
    track_name VARCHAR(100),
    race_date DATE
);

CREATE TABLE results (
    result_id INT PRIMARY KEY,
    race_id INT,
    driver_id INT,
    constructor_id INT,
    grid INT NULL,
    position INT NULL,
    positionOrder INT NULL,
    position_des VARCHAR(10),
    points FLOAT NULL,
    statusId INT NULL
);

CREATE TABLE results_staging (
result_id VARCHAR(50),
race_id VARCHAR(50),
driver_id VARCHAR(50),
constructor_id VARCHAR(50),
grid VARCHAR(50),
position VARCHAR(50),
positionOrder VARCHAR(50),
position_des VARCHAR(50),
points VARCHAR(50),
statusId VARCHAR(50)
);

SELECT COUNT(*) FROM drivers;
SELECT COUNT(*) FROM constructors;
SELECT COUNT(*) FROM races;
SELECT COUNT(*) FROM results;