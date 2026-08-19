WITH DailyTotals AS (
    -- STEP 1: Squash the data to exactly one row per day
    SELECT 
        visited_on, 
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),
MovingMetrics AS (
    -- STEP 2: Calculate the 7-day rolling math
    SELECT 
        visited_on,
        SUM(daily_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(AVG(daily_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount
    FROM DailyTotals
)
-- STEP 3: Filter out the first 6 days
SELECT 
    visited_on, 
    amount, 
    average_amount
FROM MovingMetrics
WHERE visited_on >= (
    SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY) 
    FROM Customer
)
ORDER BY visited_on;