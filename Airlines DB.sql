CREATE DATABASE airline_db;
USE airline_db;
-- Creating tables:
-- Flight Operations Table
CREATE TABLE Flight_Operations (
    Flight_ID VARCHAR(10),
    Departure_Time DATETIME,
    Arrival_Time DATETIME,
    Delay_minutes INT,
    Aircraft_Type VARCHAR(10),
    Route VARCHAR(10),
    Passengers INT,
    Cancellation INT,
    Weather_Condition VARCHAR(10)
);

-- Passenger Demographics
CREATE TABLE Passenger_Demographics (
    Passenger_ID VARCHAR(10),
    Age INT,
    Gender VARCHAR(10),
    Travel_Purpose VARCHAR(10),
    Booking_Class VARCHAR(10),
    Frequent_Flyer INT
);

-- Flight Revenue
CREATE TABLE Flight_Revenue (
    Flight_ID VARCHAR(10),
    Route VARCHAR(10),
    Ticket_Price DECIMAL(10, 2),
    Revenue_per_Passenger DECIMAL(10, 2),
    Total_Revenue DECIMAL(10, 2),
    Booking_Time DATETIME
);

-- Flight Load
CREATE TABLE Flight_Load (
    Flight_ID VARCHAR(10),
    Available_Seats INT,
    Booked_Seats INT,
    Load_Factor DECIMAL(5, 2)
);

-- Customer Feedback Data
CREATE TABLE Customer_Feedback (
    Survey_ID VARCHAR(10),
    Flight_ID VARCHAR(10),
    Satisfaction_Rating INT,
    Feedback_Category VARCHAR(20)
);

-- Flight Delay Data
CREATE TABLE Flight_Delay (
    Flight_ID VARCHAR(10),
    Delay_Duration INT,   -- in minutes
    Cancellation_Reason VARCHAR(50),
    Delayed_Flight INT    -- 0: No, 1: Yes
);

-- Fuel Consumption Data
CREATE TABLE Fuel_Consumption (
    Flight_ID VARCHAR(10),
    Fuel_Used DECIMAL(10, 2),    -- in gallons
    Flight_Distance INT,         -- in miles
    Payload_Weight INT,          -- in pounds
    Fuel_Efficiency DECIMAL(5, 2)   -- gallons per mile
);

-- Fuel consumption Data
CREATE TABLE Aircraft_Maintenance (
    Aircraft_ID VARCHAR(10),
    Maintenance_Date DATETIME,
    Maintenance_Type VARCHAR(20),
    Downtime INT,               -- in hours
    Repair_Cost DECIMAL(10, 2), -- in USD
    Part_Replaced VARCHAR(50)
);

-- Airline Workforce Data
CREATE TABLE Workforce (
    Employee_ID VARCHAR(10),
    Department VARCHAR(20),
    Performance_Rating INT,
    Training_Completed INT,  -- 0: No, 1: Yes
    Working_Hours INT        -- per month
);

-- Competitor Analysis Data
CREATE TABLE Competitor_Analysis (
    Competitor_ID VARCHAR(10),
    Competitor_Name VARCHAR(50),
    Market_Share DECIMAL(5, 2),   -- in percentage
    Average_Ticket_Price DECIMAL(10, 2),
    Load_Factor DECIMAL(5, 2)
);


-- SHOW TABLES;

-- Load Datasets to MYSQL DB Tables
-- Insert Dummy Data into Flight_Operations Table:

-- Insert 5,000 records into Flight_Operations table
ALTER TABLE Flight_Operations
MODIFY COLUMN Aircraft_Type VARCHAR(30);

INSERT INTO Flight_Operations (Flight_ID, Departure_Time, Arrival_Time, Delay_minutes, Aircraft_Type, Route, Passengers, Cancellation, Weather_Condition)
SELECT 
    CONCAT('FL', UUID_SHORT() % 10000),                             -- Random Flight ID
    DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY),             -- Random departure date within next 30 days
    DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) + 1 HOUR),       -- Random arrival date, 1 hour after departure
    FLOOR(RAND() * 120),                                              -- Random delay minutes (0 to 120)
    IF(RAND() < 0.5, 'B737', 'A320'),                                 -- Shortened aircraft type (B737 or A320)
    CONCAT('Route', FLOOR(RAND() * 10) + 1),                          -- Random route names (Route1, Route2, etc.)
    FLOOR(RAND() * 500) + 50,                                         -- Random passengers (50 to 500)
    IF(RAND() < 0.1, 1, 0),                                           -- Random cancellations (10% chance of cancellation)
    IF(RAND() < 0.5, 'Clear', 'Cloudy')                               -- Random weather conditions (Clear or Cloudy)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;

--  Insert Data into Passenger_Demographics Table
-- Insert 5,000 records into Passenger_Demographics table
ALTER TABLE Passenger_Demographics
MODIFY COLUMN Booking_Class VARCHAR(20);

-- Insert 5,000 records into Passenger_Demographics table with shortened values for Booking_Class
INSERT INTO Passenger_Demographics (Passenger_ID, Age, Gender, Travel_Purpose, Booking_Class, Frequent_Flyer)
SELECT 
    CONCAT('P', UUID_SHORT() % 10000),                      -- Random Passenger ID
    FLOOR(RAND() * 60) + 18,                                -- Random age between 18 and 78
    IF(RAND() < 0.5, 'Male', 'Female'),                      -- Random gender (Male or Female)
    IF(RAND() < 0.5, 'Business', 'Leisure'),                -- Random travel purpose (Business or Leisure)
    IF(RAND() < 0.5, 'Eco', 'First'),                       -- Shortened booking class (Eco or First)
    IF(RAND() < 0.2, 1, 0)                                  -- Random frequent flyer status (20% chance of being frequent flyer)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;


-- Insert Data into Flight_Delay Table
-- Insert 5,000 records into Flight_Delay table
INSERT INTO Flight_Delay (Flight_ID, Delay_Duration, Cancellation_Reason, Delayed_Flight)
SELECT 
    CONCAT('FL', UUID_SHORT() % 10000),                                -- Random Flight ID
    FLOOR(RAND() * 120),                                               -- Random delay duration (0 to 120 minutes)
    IF(RAND() < 0.5, 'Weather', 'Technical Issue'),                     -- Random cancellation reason (Weather or Technical Issue)
    IF(RAND() < 0.8, 1, 0)                                             -- Random delayed flights (80% chance of delay)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;


-- Insert Data into Fuel_Consumption Table
-- Insert 5,000 records into Fuel_Consumption table
INSERT INTO Fuel_Consumption (Flight_ID, Fuel_Used, Flight_Distance, Payload_Weight, Fuel_Efficiency)
SELECT 
    CONCAT('FL', UUID_SHORT() % 10000),                                -- Random Flight ID
    ROUND(RAND() * 5000 + 1000, 2),                                    -- Random fuel used (1000 to 6000 gallons)
    FLOOR(RAND() * 1500 + 500),                                        -- Random flight distance (500 to 2000 miles)
    FLOOR(RAND() * 30000 + 10000),                                     -- Random payload weight (10,000 to 40,000 pounds)
    ROUND(RAND() * 0.5 + 0.1, 2)                                       -- Random fuel efficiency (0.1 to 0.6 gallons per mile)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;

-- Insert Data into Aircraft_Maintenance Table
-- Insert 5,000 records into Aircraft_Maintenance table
INSERT INTO Aircraft_Maintenance (Aircraft_ID, Maintenance_Date, Maintenance_Type, Downtime, Repair_Cost, Part_Replaced)
SELECT 
    CONCAT('A', UUID_SHORT() % 10000),                                  -- Random Aircraft ID
    DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY),                -- Random maintenance date within the last year
    IF(RAND() < 0.5, 'Engine', 'Wings'),                                 -- Random maintenance type (Engine or Wings)
    FLOOR(RAND() * 50),                                                  -- Random downtime in hours (0 to 50 hours)
    ROUND(RAND() * 5000, 2),                                             -- Random repair cost between 0 and 5000
    IF(RAND() < 0.5, 'Engine', 'Wing Flaps')                             -- Random part replaced (Engine or Wing Flaps)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;

-- Insert Data into Workforce Table
-- Insert 5,000 records into Workforce table
INSERT INTO Workforce (Employee_ID, Department, Performance_Rating, Training_Completed, Working_Hours)
SELECT 
    CONCAT('E', UUID_SHORT() % 10000),                                 -- Random Employee ID
    IF(RAND() < 0.5, 'Maintenance', 'Customer Service'),               -- Random department (Maintenance or Customer Service)
    FLOOR(RAND() * 5) + 1,                                              -- Random performance rating (1 to 5)
    IF(RAND() < 0.5, 1, 0),                                             -- Random training completed (50% chance of completion)
    FLOOR(RAND() * 160) + 20                                            -- Random working hours (20 to 180 hours)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;


-- Insert Data into Competitor_Analysis Table
-- Insert 5,000 records into Competitor_Analysis table
INSERT INTO Competitor_Analysis (Competitor_ID, Competitor_Name, Market_Share, Average_Ticket_Price, Load_Factor)
SELECT 
    CONCAT('C', UUID_SHORT() % 10000),                                -- Random Competitor ID
    CONCAT('Competitor', FLOOR(RAND() * 1000)),                        -- Random Competitor Name
    ROUND(RAND() * 100, 2),                                            -- Random market share (0 to 100%)
    ROUND(RAND() * 500 + 50, 2),                                       -- Random average ticket price between 50 and 550
    ROUND(RAND() * 1, 2)                                               -- Random load factor (0 to 1)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;


-- Test
-- Check first 10 rows in Flight_Operations table
SELECT * FROM Flight_Operations LIMIT 10;

-- Insert 5,000 records into Flight_Operations table
INSERT INTO Flight_Operations (Flight_ID, Departure_Time, Arrival_Time, Delay_minutes, Aircraft_Type, Route, Passengers, Cancellation, Weather_Condition)
SELECT 
    CONCAT('FL', UUID_SHORT() % 10000),                             -- Random Flight ID
    DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY),             -- Random departure date within next 30 days
    DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) + 1 HOUR),       -- Random arrival date, 1 hour after departure
    FLOOR(RAND() * 120),                                              -- Random delay minutes (0 to 120)
    IF(RAND() < 0.5, 'B737', 'A320'),                                 -- Random aircraft type (B737 or A320)
    CONCAT('Route', FLOOR(RAND() * 10) + 1),                          -- Random route names (Route1, Route2, etc.)
    FLOOR(RAND() * 500) + 50,                                         -- Random passengers (50 to 500)
    IF(RAND() < 0.1, 1, 0),                                           -- Random cancellations (10% chance of cancellation)
    IF(RAND() < 0.5, 'Clear', 'Cloudy')                               -- Random weather conditions (Clear or Cloudy)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;


-- Insert 5,000 records into Flight_Operations table
INSERT INTO Flight_Operations (Flight_ID, Departure_Time, Arrival_Time, Delay_minutes, Aircraft_Type, Route, Passengers, Cancellation, Weather_Condition)
SELECT 
    CONCAT('FL', LPAD(FLOOR(RAND() * 10000), 4, '0')),          -- Flight ID (FL0001, FL0002, etc.)
    DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY),        -- Random departure date within next 30 days
    DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) + 1 HOUR),  -- Random arrival date, 1 hour after departure
    FLOOR(RAND() * 120),                                         -- Random delay minutes (0 to 120)
    IF(RAND() < 0.5, 'B737', 'A320'),                            -- Random aircraft type (B737 or A320)
    CONCAT('Route', FLOOR(RAND() * 10) + 1),                     -- Random route names (Route1, Route2, etc.)
    FLOOR(RAND() * 500) + 50,                                    -- Random passengers (50 to 500)
    IF(RAND() < 0.1, 1, 0),                                      -- Random cancellations (10% chance of cancellation)
    IF(RAND() < 0.5, 'Clear', 'Cloudy')                          -- Random weather conditions (Clear or Cloudy)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;



-- Insert 5,000 records into Flight_Operations table with random values
-- Insert 5,000 records into Flight_Operations table with random values
INSERT INTO Flight_Operations (Flight_ID, Departure_Time, Arrival_Time, Delay_minutes, Aircraft_Type, Route, Passengers, Cancellation, Weather_Condition)
SELECT 
    CONCAT('FL', LPAD(FLOOR(RAND() * 10000), 4, '0')),          -- Generate Flight ID: e.g., FL0001, FL0002
    DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY),        -- Random departure date within the next 30 days
    DATE_ADD(DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY), INTERVAL 1 HOUR),  -- Random arrival date 1 hour after departure
    FLOOR(RAND() * 121),                                         -- Random delay minutes between 0 and 120 minutes
    IF(RAND() < 0.5, 'B737', 'A320'),                            -- Random aircraft type (50% chance for either type)
    CONCAT('Route', FLOOR(RAND() * 10) + 1),                     -- Random route names (Route1, Route2, ..., Route10)
    FLOOR(RAND() * 451) + 50,                                    -- Random passengers between 50 and 500
    IF(RAND() < 0.1, 1, 0),                                      -- 10% chance of flight cancellation
    IF(RAND() < 0.5, 'Clear', 'Cloudy')                          -- Random weather conditions (50% chance of either)
FROM (SELECT 1 FROM dual LIMIT 5000) AS temp;



-- Insert 10,000 random records into Flight_Operations table
INSERT INTO Flight_Operations (Flight_ID, Departure_Time, Arrival_Time, Delay_minutes, Aircraft_Type, Route, Passengers, Cancellation, Weather_Condition)
SELECT 
    CONCAT('FL', LPAD(FLOOR(RAND() * 10000), 4, '0')),        -- Flight ID: e.g., FL0001, FL0002, etc.
    DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY),       -- Random departure date within next 30 days
    DATE_ADD(DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY), INTERVAL 1 HOUR), -- Arrival date, 1 hour after departure
    FLOOR(RAND() * 120),                                        -- Random delay time (0 to 120 minutes)
    IF(RAND() < 0.5, 'B737', 'A320'),                           -- Aircraft type (B737 or A320)
    CONCAT('Route', FLOOR(RAND() * 10) + 1),                    -- Random route names (Route1 to Route10)
    FLOOR(RAND() * 500) + 50,                                   -- Random number of passengers (50 to 500)
    IF(RAND() < 0.1, 1, 0),                                     -- 10% chance of cancellation
    IF(RAND() < 0.5, 'Clear', 'Cloudy')                         -- Random weather condition (Clear or Cloudy)
FROM (SELECT 1 FROM dual LIMIT 10000) AS temp;



SELECT * FROM Flight_Operations LIMIT 20;



-- Flight Load Analysis
-- Average load factor (Booked Seats / Available Seats) for all flights
SELECT AVG(Load_Factor) AS avg_load_factor
FROM Flight_Load;

-- Flights with high load factor (> 80%)
SELECT Flight_ID, Load_Factor
FROM Flight_Load
WHERE Load_Factor > 0.8;

-- Average load factor by Route
SELECT Route, AVG(Load_Factor) AS avg_load_factor
FROM Flight_Load
GROUP BY Route;


-- Flight Revenue Analysis
-- Total revenue for all flights
SELECT SUM(Total_Revenue) AS total_revenue
FROM Flight_Revenue;

-- Average revenue per flight
SELECT AVG(Total_Revenue) AS avg_revenue
FROM Flight_Revenue;

-- Revenue by Booking Class
SELECT Booking_Class, SUM(Total_Revenue) AS total_revenue
FROM Flight_Revenue
GROUP BY Booking_Class;


-- Customer Satisfaction Analysis
-- Average satisfaction rating for all flights
SELECT AVG(Satisfaction_Rating) AS avg_satisfaction
FROM Customer_Feedback;

-- Count of positive vs negative feedback
SELECT Feedback_Category, COUNT(*) AS feedback_count
FROM Customer_Feedback
GROUP BY Feedback_Category;

-- Average satisfaction by Flight
SELECT Flight_ID, AVG(Satisfaction_Rating) AS avg_satisfaction
FROM Customer_Feedback
GROUP BY Flight_ID;

-- Passenger Demographics Analysis
-- Average age of passengers
SELECT AVG(Age) AS avg_age
FROM Passenger_Demographics;

-- Gender distribution
SELECT Gender, COUNT(*) AS count
FROM Passenger_Demographics
GROUP BY Gender;

-- Travel purpose distribution
SELECT Travel_Purpose, COUNT(*) AS count
FROM Passenger_Demographics
GROUP BY Travel_Purpose;

-- Booking Class distribution
SELECT Booking_Class, COUNT(*) AS count
FROM Passenger_Demographics
GROUP BY Booking_Class;

-- Revenue and Load Analysis by Route
-- Average revenue and load factor by Route
SELECT 
    Route, 
    AVG(Total_Revenue) AS avg_revenue, 
    AVG(Load_Factor) AS avg_load_factor
FROM 
    Flight_Revenue
JOIN Flight_Load ON Flight_Revenue.Flight_ID = Flight_Load.Flight_ID
GROUP BY Route;

--  Cancellation Analysis
-- Cancellation rate (percentage of flights cancelled)
SELECT 
    (COUNT(*) / (SELECT COUNT(*) FROM Flight_Operations)) * 100 AS cancellation_rate
FROM Flight_Operations
WHERE Cancellation = 1;

-- Cancellation reasons (if available in `Flight_Delay`)
SELECT 
    Cancellation_Reason, 
    COUNT(*) AS cancellation_count
FROM Flight_Delay
GROUP BY Cancellation_Reason;

-- Weather Condition Impact on Delays
-- Average delay time by weather condition
SELECT 
    Weather_Condition, 
    AVG(Delay_minutes) AS avg_delay
FROM 
    Flight_Operations
GROUP BY 
    Weather_Condition;

-- Revenue Optimization Analysis by Route and Aircraft Type
WITH Route_Revenue AS (
    SELECT 
        Flight_Revenue.Route, 
        Flight_Operations.Aircraft_Type,
        SUM(Flight_Revenue.Total_Revenue) AS total_revenue,
        SUM(Flight_Load.Booked_Seats) AS total_passengers,
        AVG(Flight_Load.Load_Factor) AS avg_load_factor
    FROM 
        Flight_Revenue
    JOIN Flight_Operations ON Flight_Revenue.Flight_ID = Flight_Operations.Flight_ID
    JOIN Flight_Load ON Flight_Operations.Flight_ID = Flight_Load.Flight_ID
    GROUP BY 
        Flight_Revenue.Route, Flight_Operations.Aircraft_Type
)

SELECT 
    Route,
    Aircraft_Type,
    total_revenue,
    total_passengers,
    avg_load_factor,
    CASE 
        WHEN avg_load_factor > 0.8 THEN 'High Profitability'
        WHEN avg_load_factor BETWEEN 0.5 AND 0.8 THEN 'Medium Profitability'
        ELSE 'Low Profitability'
    END AS profitability
FROM Route_Revenue
ORDER BY total_revenue DESC;

-- Passenger Churn Prediction Using Transactional and Demographic Data
WITH Churn_Prediction AS (
    SELECT 
        p.Passenger_ID,
        p.Age,
        p.Gender,
        p.Travel_Purpose,
        p.Booking_Class,
        SUM(t.transaction_amount) AS total_spent,
        COUNT(b.bet_id) AS total_bets,
        MAX(t.transaction_date) AS last_transaction_date,
        DATEDIFF(CURDATE(), MAX(t.transaction_date)) AS days_since_last_transaction,
        CASE 
            WHEN DATEDIFF(CURDATE(), MAX(t.transaction_date)) > 90 THEN 1
            ELSE 0
        END AS churn_risk
    FROM 
        Passenger_Demographics p
    LEFT JOIN transactions t ON p.Passenger_ID = t.Passenger_ID
    LEFT JOIN player_bets b ON p.Passenger_ID = b.Passenger_ID
    GROUP BY p.Passenger_ID, p.Age, p.Gender, p.Travel_Purpose, p.Booking_Class
)

SELECT 
    Passenger_ID,
    Age,
    Gender,
    Travel_Purpose,
    Booking_Class,
    total_spent,
    total_bets,
    last_transaction_date,
    days_since_last_transaction,
    churn_risk,
    CASE 
        WHEN churn_risk = 1 THEN 'High Risk'
        ELSE 'Low Risk'
    END AS churn_category
FROM Churn_Prediction;


-- Revenue by Aircraft Type and Route Using Window Functions
WITH Route_Revenue AS (
    SELECT 
        f.Route, 
        f.Aircraft_Type,
        SUM(fr.Total_Revenue) AS total_revenue,
        AVG(fl.Load_Factor) AS avg_load_factor,
        SUM(fl.Booked_Seats) AS total_passengers
    FROM 
        Flight_Operations f
    JOIN Flight_Revenue fr ON f.Flight_ID = fr.Flight_ID
    JOIN Flight_Load fl ON f.Flight_ID = fl.Flight_ID
    GROUP BY f.Route, f.Aircraft_Type
)

SELECT 
    Route,
    Aircraft_Type,
    total_revenue,
    total_passengers,
    avg_load_factor,
    CASE 
        WHEN avg_load_factor > 0.8 THEN 'High Profitability'
        WHEN avg_load_factor BETWEEN 0.5 AND 0.8 THEN 'Medium Profitability'
        ELSE 'Low Profitability'
    END AS profitability
FROM Route_Revenue
ORDER BY total_revenue DESC;

-- Flight Delay Prediction Analysis

WITH Delay_Prediction AS (
    SELECT 
        f.Flight_ID,
        f.Aircraft_Type,
        f.Route,
        f.Weather_Condition,
        AVG(fd.Delay_Duration) AS avg_delay,
        CASE 
            WHEN f.Weather_Condition = 'Cloudy' AND f.Aircraft_Type = 'B737' THEN 'High Risk'
            WHEN f.Weather_Condition = 'Clear' AND f.Aircraft_Type = 'A320' THEN 'Low Risk'
            ELSE 'Medium Risk'
        END AS delay_risk
    FROM 
        Flight_Operations f
    LEFT JOIN Flight_Delay fd ON f.Flight_ID = fd.Flight_ID
    GROUP BY f.Flight_ID, f.Aircraft_Type, f.Route, f.Weather_Condition
)

SELECT 
    Flight_ID,
    Aircraft_Type,
    Route,
    Weather_Condition,
    avg_delay,
    delay_risk
FROM Delay_Prediction;

-- Customer Segmentation and Spending Behavior
WITH Customer_Segment AS (
    SELECT 
        pd.Passenger_ID,
        SUM(fr.Total_Revenue) AS total_spent,
        COUNT(DISTINCT f.Flight_ID) AS total_flights,  -- Count distinct flights
        AVG(fl.Load_Factor) AS avg_load_factor,
        CASE 
            WHEN SUM(fr.Total_Revenue) > 1000 THEN 'High Value'
            WHEN SUM(fr.Total_Revenue) BETWEEN 500 AND 1000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_value
    FROM 
        Passenger_Demographics pd
    LEFT JOIN Flight_Revenue fr ON pd.Passenger_ID = fr.Passenger_ID
    LEFT JOIN Flight_Bookings fb ON pd.Passenger_ID = fb.Passenger_ID  -- Assuming there is a booking table
    LEFT JOIN Flight_Operations f ON fb.Flight_ID = f.Flight_ID  -- Connecting booking data with flights
    LEFT JOIN Flight_Load fl ON f.Flight_ID = fl.Flight_ID
    GROUP BY pd.Passenger_ID
)

SELECT 
    Passenger_ID,
    total_spent,
    total_flights,
    avg_load_factor,
    customer_value
FROM Customer_Segment
ORDER BY total_spent DESC;


-- Flight Performance by Route and Aircraft Type
WITH Flight_Performance AS (
    SELECT 
        f.Route,
        f.Aircraft_Type,
        AVG(fl.Load_Factor) AS avg_load_factor,
        AVG(fr.Revenue_per_Passenger) AS avg_revenue_per_passenger
    FROM 
        Flight_Operations f
    JOIN Flight_Revenue fr ON f.Flight_ID = fr.Flight_ID
    JOIN Flight_Load fl ON f.Flight_ID = fl.Flight_ID
    GROUP BY f.Route, f.Aircraft_Type
)

SELECT 
    Route,
    Aircraft_Type,
    avg_load_factor,
    avg_revenue_per_passenger,
    CASE 
        WHEN avg_load_factor > 0.8 THEN 'High Performance'
        WHEN avg_load_factor BETWEEN 0.5 AND 0.8 THEN 'Medium Performance'
        ELSE 'Low Performance'
    END AS performance
FROM Flight_Performance
ORDER BY avg_revenue_per_passenger DESC;

