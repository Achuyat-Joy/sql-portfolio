WITH RECURSIVE Pattern AS (
    -- Step 1: Start the assembly line at the very bottom
    SELECT 1 AS stars
    
    UNION ALL
    
    -- Step 2: The Loop (Add 1 until we hit 20)
    SELECT stars + 1 
    FROM Pattern 
    WHERE stars < 20
)
-- Step 3: Print the exact number of stars for each row
SELECT REPEAT('* ', stars) 
FROM Pattern;