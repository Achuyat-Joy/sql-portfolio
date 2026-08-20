WITH AllFriends AS (
    -- Get all the people who sent a request
    SELECT requester_id AS id 
    FROM RequestAccepted
    
    UNION ALL
    
    -- Stack all the people who received a request right underneath
    SELECT accepter_id AS id 
    FROM RequestAccepted
)

-- Now just treat it like a normal, single-column table!
SELECT 
    id, 
    COUNT(id) AS num
FROM AllFriends
GROUP BY id
ORDER BY num DESC
LIMIT 1;