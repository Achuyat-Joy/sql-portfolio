WITH UserSummary AS (
    -- Step 1: Crush the entire history to get lifetime statistics
    SELECT 
        user_id,
        MIN(event_date) AS first_date,
        MAX(event_date) AS last_date,
        MAX(monthly_amount) AS max_historical_amount,
        SUM(CASE WHEN event_type = 'downgrade' THEN 1 ELSE 0 END) AS downgrade_count
    FROM subscription_events
    GROUP BY user_id
),
LatestEvent AS (
    -- Step 2: Take a snapshot of their absolute newest state
    SELECT 
        user_id,
        event_type AS last_event_type,
        plan_name AS current_plan,
        monthly_amount AS current_monthly_amount
    FROM (
        SELECT 
            user_id,
            event_type,
            plan_name,
            monthly_amount,
            ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY event_date DESC, event_id DESC) AS rn
        FROM subscription_events
    ) ranked
    WHERE rn = 1
)
-- Step 3: Join the lifetime stats with the current snapshot and filter
SELECT 
    u.user_id,
    l.current_plan,
    l.current_monthly_amount,
    u.max_historical_amount,
    DATEDIFF(u.last_date, u.first_date) AS days_as_subscriber
FROM UserSummary u
JOIN LatestEvent l ON u.user_id = l.user_id
WHERE l.last_event_type != 'cancel'
  AND u.downgrade_count > 0
  AND l.current_monthly_amount < (u.max_historical_amount * 0.5)
  AND DATEDIFF(u.last_date, u.first_date) >= 60
ORDER BY 
    days_as_subscriber DESC, 
    u.user_id ASC;