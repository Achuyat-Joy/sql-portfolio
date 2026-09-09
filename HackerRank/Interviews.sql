WITH Challenge_Views AS (
    -- Step 1: Pre-aggregate all views down to exactly one row per challenge
    SELECT 
        challenge_id,
        SUM(total_views) AS total_views,
        SUM(total_unique_views) AS total_unique_views
    FROM View_Stats
    GROUP BY challenge_id
),
Challenge_Submissions AS (
    -- Step 2: Pre-aggregate all submissions down to exactly one row per challenge
    SELECT 
        challenge_id,
        SUM(total_submissions) AS total_submissions,
        SUM(total_accepted_submissions) AS total_accepted_submissions
    FROM Submission_Stats
    GROUP BY challenge_id
)
-- Step 3: The Main Assembly Line
SELECT 
    con.contest_id,
    con.hacker_id,
    con.name,
    SUM(cs.total_submissions),
    SUM(cs.total_accepted_submissions),
    SUM(cv.total_views),
    SUM(cv.total_unique_views)
FROM Contests con
JOIN Colleges col 
    ON con.contest_id = col.contest_id
JOIN Challenges cha 
    ON col.college_id = cha.college_id
-- Step 4: Safely attach our pre-squashed stats using LEFT JOINs
LEFT JOIN Challenge_Views cv 
    ON cha.challenge_id = cv.challenge_id
LEFT JOIN Challenge_Submissions cs 
    ON cha.challenge_id = cs.challenge_id
GROUP BY 
    con.contest_id, 
    con.hacker_id, 
    con.name
-- Step 5: The Logic Gate to drop the 0-stat contests
HAVING SUM(cs.total_submissions) > 0 
    OR SUM(cs.total_accepted_submissions) > 0 
    OR SUM(cv.total_views) > 0 
    OR SUM(cv.total_unique_views) > 0
ORDER BY con.contest_id;