WITH ChallengeCounts AS (
    -- Step 1: The Assembly Line (Calculate totals for everyone)
    SELECT 
        h.hacker_id, 
        h.name, 
        COUNT(c.challenge_id) AS total_challenges
    FROM Hackers h
    JOIN Challenges c 
        ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, h.name
)
-- Step 2: The Logic Gates (Filter based on Julia's strict rules)
SELECT 
    hacker_id, 
    name, 
    total_challenges
FROM ChallengeCounts
WHERE total_challenges = (
    -- Gate A: Keep them if they tied for the absolute MAXIMUM amount
    SELECT MAX(total_challenges) 
    FROM ChallengeCounts
)
OR total_challenges IN (
    -- Gate B: Keep them if their count is totally UNIQUE (nobody else has this exact number)
    SELECT total_challenges
    FROM ChallengeCounts
    GROUP BY total_challenges
    HAVING COUNT(total_challenges) = 1
)
ORDER BY total_challenges DESC, hacker_id ASC;