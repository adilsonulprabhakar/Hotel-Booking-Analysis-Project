
# Hotel Booking Analysis Project

## Project Overview
This project focuses on analyzing hotel booking data to gain valuable insights into guest behavior and operational aspects at Marriott Hotel. The goal is to identify trends in booking patterns, customer preferences, and factors affecting key performance indicators such as cancellation rates, revenue, and average daily rates (ADR).

### Key Objectives:
1. **Analyze Booking Patterns**: Understand guest behavior by analyzing booking trends over time, lead time, length of stay, and seasonal patterns.
2. **Cancellation Analysis**: Explore factors influencing cancellation rates, including waiting list status, booking channels, and previous booking history.
3. **Customer Segmentation**: Identify unique customer segments based on attributes like customer type, group composition, and booking frequency.
4. **Revenue Metrics**: Calculate metrics such as ADR, revenue per booking, and the impact of special requests on revenue.
5. **Room Assignment & Upgrades**: Evaluate discrepancies between reserved and assigned room types and identify any trends in room upgrades or downgrades.

---

## Data Schema

### Table: `hotel_bookings`

| Column Name                    | Data Type           | Description |
|--------------------------------|---------------------|-------------|
| `hotel`                        | VARCHAR(50)        | Hotel name (e.g., City Hotel, Resort Hotel) |
| `is_canceled`                  | TINYINT            | Booking cancellation status (1 = canceled, 0 = not canceled) |
| `lead_time`                    | INT                | Number of days between booking date and arrival date |
| `arrival_date_year`            | YEAR               | Year of arrival date |
| `arrival_date_month`           | VARCHAR(15)        | Month of arrival date |
| `arrival_date_week_number`     | INT                | Week number of arrival date |
| `arrival_date_day_of_month`    | INT                | Day of the month for arrival |
| `stays_in_weekend_nights`      | INT                | Number of weekend nights the guest stayed |
| `stays_in_week_nights`         | INT                | Number of weeknights the guest stayed |
| `adults`                       | INT                | Number of adults in booking |
| `children`                     | INT                | Number of children in booking |
| `babies`                       | INT                | Number of babies in booking |
| `meal`                         | VARCHAR(10)        | Type of meal plan booked |
| `country`                      | CHAR(3)            | Guest’s country of residence |
| `market_segment`               | VARCHAR(20)        | Segment through which booking was made |
| `distribution_channel`         | VARCHAR(20)        | Distribution channel for booking |
| `is_repeated_guest`            | TINYINT            | Indicates if guest has previously booked |
| `previous_cancellations`       | INT                | Number of previous cancellations by guest |
| `previous_bookings_not_canceled` | INT             | Number of previous bookings not canceled by guest |
| `reserved_room_type`           | CHAR(1)            | Room type reserved |
| `assigned_room_type`           | CHAR(1)            | Room type assigned |
| `booking_changes`              | INT                | Number of changes made to the booking |
| `deposit_type`                 | VARCHAR(20)        | Type of deposit required for booking |
| `agent`                        | VARCHAR(10)        | Booking agent ID |
| `company`                      | VARCHAR(10)        | Company ID if corporate booking |
| `days_in_waiting_list`         | INT                | Number of days booking was on waiting list |
| `customer_type`                | VARCHAR(20)        | Type of customer (e.g., transient, group) |
| `adr`                          | DECIMAL(6,2)       | Average daily rate per booking |
| `required_car_parking_spaces`  | INT                | Number of car parking spaces required |
| `total_of_special_requests`    | INT                | Number of special requests made by guest |
| `reservation_status`           | VARCHAR(20)        | Reservation status (e.g., Check-Out, Canceled) |
| `reservation_status_date`      | DATE               | Date of last reservation status change |
| `name`                         | VARCHAR(50)        | Name of guest |
| `email`                        | VARCHAR(50)        | Guest’s email address |
| `phone_number`                 | VARCHAR(20)        | Guest’s phone number |
| `credit_card`                  | VARCHAR(16)        | Guest’s credit card number (last four digits if masked) |

---

## Analysis Topics

### 1. **Cancellation Analysis**
   - **Objective**: Identify factors impacting cancellation rates.
   - **Parameters Analyzed**:
     - Seasonal patterns in cancellations by month.
     - Impact of waiting list status on cancellation likelihood.
     - Relationship between booking lead time and cancellation rates.

### 2. **Booking Channel and Market Segment Analysis**
   - **Objective**: Understand booking behavior across distribution channels.
   - **Parameters Analyzed**:
     - Booking frequency and cancellation rates across different channels (e.g., travel agents, direct, online).
     - Comparison of ADR and length of stay by booking channel.
     - Identification of high-revenue market segments.

### 3. **Guest Segmentation**
   - **Objective**: Segment customers based on demographics and behavior.
   - **Parameters Analyzed**:
     - Grouping by customer type, repeat guest status, and family composition (e.g., adults, children, babies).
     - Analysis of length of stay, booking frequency, and ADR across segments.
     - Popular meal plans and amenities required by different customer segments.

### 4. **Room Type Analysis**
   - **Objective**: Evaluate guest satisfaction and upgrade/downgrade trends.
   - **Parameters Analyzed**:
     - Comparison of reserved vs. assigned room types.
     - Frequency and reasons for room upgrades/downgrades.
     - Room type preferences and impact on booking changes.

### 5. **Revenue Analysis**
   - **Objective**: Determine factors affecting revenue generation.
   - **Parameters Analyzed**:
     - Calculation of total revenue per booking based on ADR and length of stay.
     - Impact of special requests on ADR and total revenue.
     - Average ADR comparison by market segment, distribution channel, and season.

### 6. **Special Requests Impact**
   - **Objective**: Assess the role of special requests in guest satisfaction and revenue.
   - **Parameters Analyzed**:
     - Correlation between the number of special requests and cancellation rates.
     - Average ADR for bookings with vs. without special requests.
     - Distribution of special requests by room type and booking channel.

## Key Analytical Questions

### Booking Trends
1. What is the average lead time for hotel bookings?
2. Which month and year have the highest number of bookings?
3. How do booking patterns vary by market segment (e.g., corporate, online, direct)?
4. What is the peak season for hotel bookings (based on `arrival_date_year` and `arrival_date_month`)?

### Cancellation Analysis
1. What percentage of bookings are canceled? (Use `is_canceled`)
2. Which months have the highest cancellation rates?
3. Is there a correlation between the length of stay and cancellations?
4. Do repeated guests (based on `is_repeated_guest`) have a higher cancellation rate compared to first-time guests?
5. How many customers have previous cancellations, and how does that affect future bookings?

### Customer Segmentation
1. How do different customer types (e.g., `customer_type`) behave in terms of booking frequency, length of stay, or cancellation?
2. What is the average age group (if inferred from `children`, `adults`, `babies`) of hotel guests?
3. How does the number of people (`adults`, `children`, `babies`) affect the length of stay?

### Room Type Analysis
1. What is the most popular room type reserved (`reserved_room_type`) vs. the one assigned (`assigned_room_type`)?
2. Are there any discrepancies in the room assignments (e.g., `reserved_room_type` vs. `assigned_room_type`)?
3. Which types of rooms are most frequently upgraded or downgraded?

### Revenue Analysis
1. What is the average daily rate (ADR) for different room types (`adr`)?
2. Which market segment has the highest ADR?
3. How do special requests (e.g., `total_of_special_requests`) impact the ADR?
4. What is the total revenue per booking based on `adr`, `stays_in_weekend_nights`, and `stays_in_week_nights`?

### Booking Behavior
1. How many bookings have special requests? (Use `total_of_special_requests`)
2. How does the number of requests correlate with the type of meal or deposit type (`meal`, `deposit_type`)?
3. How many bookings involve car parking spaces, and does that affect the cancellation rate?

### Customer Data Insights
1. How many bookings are associated with specific customers based on email or phone number?
2. What percentage of customers provide email, phone, and credit card information? (e.g., `email`, `phone_number`, `credit_card`)
3. What is the average number of booking changes (`booking_changes`) per customer?

### Waiting List and Booking Conversion
1. How many customers end up booking after being on the waiting list (`days_in_waiting_list`)?
2. What percentage of bookings come from customers on the waiting list?
3. Is there a significant difference in cancellation rates between those on the waiting list and those who are not?

### Booking Channel Analysis
1. What is the most common distribution channel (`distribution_channel`) for bookings, and how does it correlate with cancellations?
2. How do bookings through travel agents (`agent`) compare to bookings made directly or online in terms of cancellations, ADR, or length of stay?
---

## Insights and Observations

### Key Findings:
1. **High Cancellation Rates**: Certain months and booking channels have a significantly higher cancellation rate, suggesting seasonal trends and channel-related differences.
2. **Impact of Waiting List on Cancellation**: Guests who are on the waiting list show a higher or lower cancellation rate depending on other factors like lead time and market segment.
3. **Revenue Contribution by Market Segment**: Corporate and transient guests contribute most to revenue, with varying ADRs across segments.
4. **Room Assignment Discrepancies**: A considerable number of bookings receive upgrades, often from standard rooms to premium rooms, based on availability.
5. **Booking Changes**: Customers with longer stays and those who make special requests tend to have a higher number of booking changes, likely to meet their specific needs.

### Potential Business Recommendations:
1. **Optimize Booking Channels**: Increase direct booking incentives to reduce cancellation rates associated with third-party channels.
2. **Targeted Marketing for Repeat Guests**: Implement loyalty programs for repeat guests to improve retention and decrease cancellations.
3. **Revenue Strategy**: Focus on segments with higher ADR and longer stays, possibly by offering packages for family groups and business travelers.
4. **Room Upgrade Policy**: Develop a structured room upgrade policy to improve guest satisfaction and encourage repeat bookings.

---

## Conclusion
The insights from this analysis can help Marriott Hotel to make data-driven decisions, optimize operations, and enhance guest experience. By understanding booking trends, customer behavior, and revenue drivers, the hotel can implement targeted strategies to increase profitability and customer satisfaction.

---
