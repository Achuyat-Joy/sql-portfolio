WITH HighTraffic AS (
    -- Step 1: Filter low traffic and calculate the "island" identifier
    SELECT 
        id, 
        visit_date, 
        people,
        id - ROW_NUMBER() OVER (ORDER BY id) AS island_id
    FROM Stadium
    WHERE people >= 100
),
IslandCounts AS (
    -- Step 2: Count the size of each island without crushing the rows
    SELECT 
        id, 
        visit_date, 
        people,
        COUNT(*) OVER (PARTITION BY island_id) AS island_size
    FROM HighTraffic
)
-- Step 3: Keep only the islands with 3 or more days
SELECT 
    id, 
    visit_date, 
    people
FROM IslandCounts
WHERE island_size >= 3
ORDER BY visit_date ASC;