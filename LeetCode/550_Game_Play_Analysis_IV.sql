WITH FirstLogin AS (
    -- Machine 1: Find the first login date for every player
    SELECT player_id, MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
)

-- Machine 2 & 3: Match them to the next day and calculate the fraction
SELECT 
    ROUND(
        COUNT(a.player_id) / COUNT(f.player_id), 
        2
    ) AS fraction
FROM FirstLogin f
LEFT JOIN Activity a 
    -- The join rules: Must be the same player, AND exactly 1 day later
    ON f.player_id = a.player_id 
    AND a.event_date = DATE_ADD(f.first_date, INTERVAL 1 DAY);