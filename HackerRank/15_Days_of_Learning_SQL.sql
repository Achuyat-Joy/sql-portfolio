WITH Hacker_Streaks AS (
    -- Track A, Step 1: Find every unique day a hacker submitted
    SELECT DISTINCT hacker_id, submission_date
    FROM Submissions
),
Streak_Counts AS (
    -- Track A, Step 2: Assign a consecutive number to their submission days
    SELECT 
        hacker_id, 
        submission_date,
        DENSE_RANK() OVER (PARTITION BY hacker_id ORDER BY submission_date) AS day_streak
    FROM Hacker_Streaks
),
Consistent_Hackers AS (
    -- Track A, Step 3: Keep them only if their streak matches the calendar day
    SELECT 
        submission_date, 
        COUNT(hacker_id) AS total_consistent
    FROM Streak_Counts
    WHERE day_streak = DAY(submission_date)
    GROUP BY submission_date
),
Daily_Stats AS (
    -- Track B, Step 1: Count total submissions per hacker per day
    SELECT 
        submission_date, 
        hacker_id, 
        COUNT(submission_id) AS daily_subs
    FROM Submissions
    GROUP BY submission_date, hacker_id
),
Ranked_Hackers AS (
    -- Track B, Step 2: Rank them to find the #1 hacker for each day
    SELECT 
        submission_date,
        hacker_id,
        ROW_NUMBER() OVER (
            PARTITION BY submission_date 
            ORDER BY daily_subs DESC, hacker_id ASC
        ) AS rank_num
    FROM Daily_Stats
)
-- Final Assembly: Join the Consistent totals with the #1 Hacker info
SELECT 
    c.submission_date,
    c.total_consistent,
    r.hacker_id,
    h.name
FROM Consistent_Hackers c
JOIN Ranked_Hackers r 
    ON c.submission_date = r.submission_date 
    AND r.rank_num = 1
JOIN Hackers h 
    ON r.hacker_id = h.hacker_id
ORDER BY c.submission_date;