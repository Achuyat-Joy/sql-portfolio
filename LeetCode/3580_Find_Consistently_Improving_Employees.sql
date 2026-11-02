WITH RankedReviews AS (
    -- Step 1: Line up the reviews chronologically from newest to oldest
    SELECT 
        employee_id, 
        rating, 
        ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rank_num
    FROM performance_reviews
),
PivotedReviews AS (
    -- Step 2: Keep only the top 3 and pivot them into a single row per employee
    SELECT 
        employee_id,
        SUM(CASE WHEN rank_num = 1 THEN rating END) AS latest_rating,
        SUM(CASE WHEN rank_num = 2 THEN rating END) AS middle_rating,
        SUM(CASE WHEN rank_num = 3 THEN rating END) AS earliest_rating
    FROM RankedReviews
    WHERE rank_num <= 3
    GROUP BY employee_id
)
-- Step 3: Check the math and calculate the final score
SELECT 
    e.employee_id, 
    e.name, 
    (p.latest_rating - p.earliest_rating) AS improvement_score
FROM PivotedReviews p
JOIN employees e ON p.employee_id = e.employee_id
WHERE p.earliest_rating IS NOT NULL
  AND p.latest_rating > p.middle_rating
  AND p.middle_rating > p.earliest_rating
ORDER BY improvement_score DESC, e.name ASC;