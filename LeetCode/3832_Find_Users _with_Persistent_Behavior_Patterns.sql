WITH SingleActionDays AS (
    -- Step 1: Keep only days where the user performed strictly one action
    SELECT 
        user_id,
        action_date,
        MIN(action) AS action
    FROM activity
    GROUP BY user_id, action_date
    HAVING COUNT(*) = 1
),
GroupedStreaks AS (
    -- Step 2: Subtract row numbers from dates to create a constant group key for consecutive days
    SELECT 
        user_id,
        action,
        action_date,
        DATE_SUB(
            action_date, 
            INTERVAL ROW_NUMBER() OVER(PARTITION BY user_id, action ORDER BY action_date) DAY
        ) AS streak_grp
    FROM SingleActionDays
),
QualifyingStreaks AS (
    -- Step 3: Crush each streak island and keep only those lasting at least 5 days
    SELECT 
        user_id,
        action,
        COUNT(*) AS streak_length,
        MIN(action_date) AS start_date,
        MAX(action_date) AS end_date
    FROM GroupedStreaks
    GROUP BY user_id, action, streak_grp
    HAVING COUNT(*) >= 5
),
RankedStreaks AS (
    -- Step 4: Rank qualifying streaks per user using the exact tie-breaking rules
    SELECT 
        user_id,
        action,
        streak_length,
        start_date,
        end_date,
        ROW_NUMBER() OVER(
            PARTITION BY user_id 
            ORDER BY streak_length DESC, action ASC, start_date DESC
        ) AS rn
    FROM QualifyingStreaks
)
-- Step 5: Output the winning streak per user and sort the final table
SELECT 
    user_id,
    action,
    streak_length,
    start_date,
    end_date
FROM RankedStreaks
WHERE rn = 1
ORDER BY streak_length DESC, user_id ASC;