create database Hotel_Analysis;
USE Hotel_Analysis;

CREATE TABLE hotel_bookings (
    hotel VARCHAR(50),
    is_canceled TINYINT,
    lead_time INT,
    arrival_date_year YEAR,
    arrival_date_month VARCHAR(15),
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children VARCHAR(10) DEFAULT NULL,
    babies INT,
    meal VARCHAR(10),
    country CHAR(3),
    market_segment VARCHAR(20),
    distribution_channel VARCHAR(20),
    is_repeated_guest TINYINT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type CHAR(1),
    assigned_room_type CHAR(1),
    booking_changes INT,
    deposit_type VARCHAR(20),
    agent VARCHAR(10),
    company VARCHAR(10),
    days_in_waiting_list INT,
    customer_type VARCHAR(20),
    adr DECIMAL(6, 2),
    required_car_parking_spaces INT,
    total_of_special_requests INT,
    reservation_status VARCHAR(20),
    reservation_status_date DATE,
    name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    credit_card VARCHAR(16)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hotel_booking.csv"
INTO TABLE hotel_bookings
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
SET children = NULLIF(children, '');



LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hotel_booking.csv"
INTO TABLE hotel_bookings
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

SET SQL_SAFE_UPDATES = 0;

UPDATE hotel_bookings
SET children = NULL
WHERE children = '';


ALTER TABLE hotel_bookings
MODIFY COLUMN children INT DEFAULT NULL;

describe hotel_bookings;
select * from hotel_bookings;

alter table hotel_bookings
add column Total_Stay_duration int;

update hotel_bookings
set total_stay_duration = stays_in_weekend_nights+stays_in_week_nights;
