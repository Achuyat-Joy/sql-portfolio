WITH RECURSIVE Pattern AS (
    -- Step 1: Start the assembly line with the maximum number
    SELECT 20 AS stars
    
    UNION ALL
    
    -- Step 2: The Loop (Subtract 1 until we hit 1)
    SELECT stars - 1 
    FROM Pattern 
    WHERE stars > 1
)
-- Step 3: Print the exact number of stars for each row
SELECT REPEAT('* ', stars) 
FROM Pattern;