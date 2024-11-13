-- Booking Trends:
-- What is the average lead time for hotel bookings?
SELECT avg(lead_time) AS acg_lead_time
FROM hotel_bookings;

-- Which month and year have the highest number of bookings?
SELECT arrival_date_month
	,count(*) AS no_of_booking
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY no_of_booking DESC;

-- How do booking patterns vary by market segment (e.g., corporate, online, direct)?
SELECT *
FROM hotel_bookings;

SELECT market_segment
	,count(*) AS no_of_bookings
FROM hotel_bookings
GROUP BY market_segment
ORDER BY no_of_bookings DESC;

-- What is the peak season for hotel bookings (based on arrival_date_year and arrival_date_month)?
-- Winter is considered December, January and February; spring is March through May; summer is June through August; and fall or autumn is September through November.
SELECT CASE 
		WHEN arrival_date_month IN (
				'December'
				,'january'
				,'february'
				)
			THEN "Winter"
		WHEN arrival_date_month IN (
				'March'
				,'april'
				,'may'
				)
			THEN "Spring"
		WHEN arrival_date_month IN (
				'june'
				,'july'
				,'august'
				)
			THEN "Summer"
		WHEN arrival_date_month IN (
				'september'
				,'october'
				,'november'
				)
			THEN "Autumn"
		ELSE "Unkwon"
		END AS seasons
	,count(*) AS no_of_bookings
FROM hotel_bookings
GROUP BY SEASONS
ORDER BY no_of_bookings DESC;

-- Cancellation Analysis:
-- What percentage of bookings are canceled? (Use is_canceled)
SELECT *
FROM hotel_bookings;

SELECT round(sum(is_canceled) / count(*) * 100, 2) AS cancelation_perct
FROM hotel_bookings;

-- Which months have the highest cancellation rates?
SELECT arrival_date_month
	,sum(is_canceled) AS no_of_cancelation
	,count(*) AS total_no_of_booking
	,round((sum(is_canceled) / count(*)) * 100, 2) AS percentage_of_cancelation
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY percentage_of_cancelation DESC;

-- Is there a correlation between the length of stay and cancellations?
SELECT is_canceled
	,AVG(Total_Stay_duration) AS avg_length_of_stay
FROM hotel_bookings
GROUP BY is_canceled
ORDER BY is_canceled;

-- Do repeated guests (based on is_repeated_guest) have a higher cancellation rate compared to first-time guests?
-- Value indicating if the booking name was from a repeated guest (1) or not (0)
SELECT CASE 
		WHEN is_repeated_guest = 0
			THEN "First-time guest"
		WHEN is_repeated_guest = 1
			THEN "Repeated Guest"
		END AS Guests
	,sum(is_canceled) AS cancelation
FROM hotel_bookings
GROUP BY is_repeated_guest;

-- How many customers have previous cancellations, and how does that affect future bookings?
SELECT *
FROM hotel_bookings;

SELECT previous_cancellations
	,count(*) AS no_of_bookins
	,count(*) - previous_cancellations AS no_of_bookings
FROM hotel_bookings
WHERE previous_cancellations > 0
GROUP BY previous_cancellations;

SELECT previous_cancellations
	,COUNT(*) AS total_bookings
	,-- Total number of bookings
	SUM(is_canceled) AS no_of_cancellations
	,-- Number of cancellations for these bookings
	COUNT(*) - SUM(is_canceled) AS no_of_non_cancellations -- Number of bookings that were not canceled
FROM hotel_bookings
WHERE previous_cancellations > 0 -- Only customers who have made previous cancellations
GROUP BY previous_cancellations
ORDER BY previous_cancellations;

-- Overall cancellation rate
SELECT AVG(is_canceled) AS overall_cancellation_rate
FROM hotel_bookings;-- 0.3704

-- Cancellation rate for customers with previous cancellations
SELECT previous_cancellations
	,AVG(is_canceled) AS cancellation_rate_for_previous_cancellations
FROM hotel_bookings
WHERE previous_cancellations > 0
GROUP BY previous_cancellations
ORDER BY previous_cancellations;

-- Customer Segmentation:
-- How do different customer types (e.g., customer_type) behave in terms of booking frequency, length of stay, or cancellation?
SELECT customer_type
	,count(*) AS total_booking
	,avg(total_stay_duration) AS avg_lenght_of_stay
	,sum(is_canceled) AS no_of_cancelation
	,count(*) - sum(is_canceled) AS no_of_non_canceled_booking
	,round(sum(is_canceled) / count(*) * 100, 2) AS cancelation_rate
FROM hotel_bookings
GROUP BY customer_type
ORDER BY no_of_non_canceled_booking DESC;

-- What is the average age group (if inferred from children, adults, babies) of hotel guests?
SELECT round(AVG((babies * 1 + children * 8 + adults * 30) / NULLIF(babies + children + adults, 0)), 2) AS avg_age_of_guests
FROM hotel_bookings;

-- How does the number of people (adults, children, babies) affect the length of stay?
SELECT CASE 
		WHEN adults = 1
			AND babies = 0
			AND children = 0
			THEN "single adult traveler"
		WHEN adults > 1
			AND babies = 0
			AND children = 0
			THEN "adult group"
		WHEN adults > 0
			AND babies > 0
			AND children = 0
			THEN "with babies"
		WHEN adults > 0
			AND babies = 0
			AND children > 0
			THEN "with children"
		WHEN adults > 0
			AND babies > 0
			AND children > 0
			THEN "with baby and children"
		WHEN adults = 0
			AND babies = 0
			AND children > 0
			THEN "children only"
		WHEN adults = 0
			AND babies > 0
			AND children > 0
			THEN "children and babies"
		WHEN adults = 0
			AND babies = 0
			AND children = 0
			THEN "empty booking"
		ELSE "Missing Values or Null"
		END AS category
	,count(*) AS total_no_of_booking
	,round(avg(total_stay_duration), 2) AS avg_lenght_of_stay
FROM hotel_bookings
GROUP BY category
ORDER BY total_no_of_booking DESC
	,avg_lenght_of_stay DESC;

-- Room Type Analysis:
-- What is the most popular room type reserved (reserved_room_type) vs. the one assigned (assigned_room_type)?
SELECT reserved_room_type
	,count(*) AS no_of_bookings
FROM hotel_bookings
GROUP BY reserved_room_type
ORDER BY no_of_bookings DESC;

SELECT assigned_room_type
	,count(*) AS no_of_bookings
FROM hotel_bookings
GROUP BY assigned_room_type
ORDER BY no_of_bookings DESC;

-- Are there any discrepancies in the room assignments (e.g., reserved_room_type vs. assigned_room_type)?
SELECT reserved_room_type
	,assigned_room_type
	,count(*) no_of_discrepancies
FROM hotel_bookings
WHERE reserved_room_type <> assigned_room_type
GROUP BY reserved_room_type
	,assigned_room_type
ORDER BY reserved_room_type;

-- Which types of rooms are most frequently upgraded or downgraded?
SELECT reserved_room_type
	,assigned_room_type
	,count(*) AS no_of_change
	,CASE 
		WHEN reserved_room_type < assigned_room_type
			THEN "Downgrade"
		WHEN reserved_room_type > assigned_room_type
			THEN "Upgrade"
		END AS Room_Status
FROM hotel_bookings
WHERE reserved_room_type <> assigned_room_type
GROUP BY reserved_room_type
	,assigned_room_type
	,room_status
ORDER BY no_of_change DESC
	,room_status DESC;

-- Revenue Analysis:
-- What is the average daily rate (ADR) for different room types (adr)?
SELECT *
FROM hotel_bookings;

SELECT assigned_room_type
	,round(avg(adr), 2) AS avg_daily_rate
FROM hotel_bookings
GROUP BY assigned_room_type
ORDER BY assigned_room_type;

-- Which market segment has the highest ADR?
SELECT *
FROM hotel_bookings;

SELECT market_segment
	,round(avg(adr), 2) AS average_daily_rate
FROM hotel_bookings
GROUP BY market_segment
ORDER BY average_daily_rate DESC;

-- How do special requests (e.g., total_of_special_requests) impact the ADR?
SELECT total_of_special_requests
	,count(*) AS no_of_booking
	,round(avg(adr), 2) AS average_daily_rate
FROM hotel_bookings
GROUP BY total_of_special_requests
ORDER BY average_daily_rate DESC;

-- What is the total revenue per booking based on adr, stays_in_weekend_nights, and stays_in_week_nights?
SELECT *
FROM hotel_bookings;

SELECT NAME
	,email
	,reservation_status_date
	,total_stay_duration
	,adr
	,total_stay_duration * adr AS revenue_per_booking
FROM hotel_bookings;

-- Booking Behavior:
-- How many bookings have special requests? (Use total_of_special_requests)
SELECT total_of_special_requests
	,count(*) AS no_of_booking
FROM hotel_bookings
WHERE total_of_special_requests > 0
GROUP BY total_of_special_requests;

-- How does the number of requests correlate with the type of meal or deposit type (meal, deposit_type)?
SELECT total_of_special_requests
	,meal
	,count(meal)
	,deposit_type
	,count(deposit_type)
FROM hotel_bookings
GROUP BY total_of_special_requests
	,meal
	,deposit_type;

-- How many bookings involve car parking spaces, and does that affect the cancellation rate?
SELECT required_car_parking_spaces
	,count(*) AS total_booking
	,sum(is_canceled) AS no_of_cancelation
	,(sum(is_canceled) / count(*)) * 100 AS cancelation_rate
FROM hotel_bookings
GROUP BY required_car_parking_spaces;

-- Customer Data Insights:
-- How many bookings are associated with specific customers based on email or phone number?
WITH emails
AS (
	SELECT email
		,count(*) AS no_of_booking
	FROM hotel_bookings
	GROUP BY email
	ORDER BY no_of_booking DESC limit 20
	)
SELECT e.*
	,h.phone_number
FROM emails e
LEFT JOIN hotel_bookings h ON e.email = h.email
ORDER BY e.email;

-- What percentage of customers provide email, phone, and credit card information? (e.g., email, phone_number, credit_card)
SELECT round((count(email) / count(*)) * 100, 2) AS cutomer_with_email
	,round((count(phone_number) / count(*)) * 100, 2) AS customer_with_phone
	,round((count(credit_card) / count(*)) * 100, 2) AS customer_with_creditcard
FROM hotel_bookings
WHERE email IS NOT NULL
	OR phone_number IS NOT NULL
	OR credit_card IS NOT NULL;

-- What is the average number of booking changes (booking_changes) per customer?
SELECT *
FROM hotel_bookings;

SELECT NAME
	,count(*) AS total_no_of_booking
	,avg(booking_changes) AS avg_booking_changes
FROM hotel_bookings
GROUP BY NAME
ORDER BY avg_booking_changes DESC;

-- Waiting List and Booking Conversion:
-- How many customers end up booking after being on the waiting list (days_in_waiting_list)?
SELECT max(days_in_waiting_list)
	,min(days_in_waiting_list)
FROM hotel_bookings;

SELECT CASE 
		WHEN days_in_waiting_list BETWEEN 1
				AND 50
			THEN "Low waiting period"
		WHEN days_in_waiting_list BETWEEN 50
				AND 100
			THEN "Moderate waiting period"
		WHEN days_in_waiting_list BETWEEN 100
				AND 200
			THEN "High waiting period"
		ELSE "Very high waiting period"
		END AS waiting_period
	,count(*) AS bookings
FROM hotel_bookings
WHERE days_in_waiting_list > 0
	AND is_canceled <> 1
GROUP BY waiting_period;

-- What percentage of bookings come from customers on the waiting list?
WITH waiting_list
AS (
	SELECT count(*) AS total_booking
	FROM hotel_bookings
	WHERE days_in_waiting_list > 0
		AND is_canceled = 0
	)
	,total_booking
AS (
	SELECT count(*) AS bookings
	FROM hotel_bookings
	)
SELECT (w.total_booking / t.bookings) * 100 AS perct_booking_waiting
FROM waiting_list w
	,total_booking t;

-- OR SIMPLER WAY
SELECT (
		COUNT(CASE 
				WHEN days_in_waiting_list > 0
					AND is_canceled = 0
					THEN 1
				END) / COUNT(*)
		) * 100 AS perct_booking_waiting
FROM hotel_bookings;

-- Is there a significant difference in cancellation rates between those on the waiting list and those who are not?
SELECT (
		COUNT(CASE 
				WHEN is_canceled = 1
					AND days_in_waiting_list > 0
					THEN 1
				END) / COUNT(CASE 
				WHEN days_in_waiting_list > 0
					THEN 1
				END)
		) * 100 AS perct_cancel_waiting
	,(
		COUNT(CASE 
				WHEN is_canceled = 1
					AND days_in_waiting_list = 0
					THEN 1
				END) / COUNT(CASE 
				WHEN days_in_waiting_list = 0
					THEN 1
				END)
		) * 100 AS perct_cancel_nonwaiting
FROM hotel_bookings;

-- Booking Channel Analysis:
-- What is the most common distribution channel (distribution_channel) for bookings, and how does it correlate with cancellations?
SELECT distribution_channel
	,count(*) AS no_of_bookings
FROM hotel_bookings
GROUP BY distribution_channel;

-- How do bookings through travel agents (agent) compare to bookings made directly or online in terms of cancellations, ADR, or length of stay?
SELECT distribution_channel
	,count(*) AS no_of_bookings
	,round(avg(adr), 2) AS avg_adr
	,round((sum(is_canceled) / count(*)) * 100, 2) AS cancelation_rate
	,round(avg(total_stay_duration), 2) AS avg_lenght_stay
FROM hotel_bookings
GROUP BY distribution_channel;
