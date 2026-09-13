WITH RECURSIVE Numbers AS (
    -- Step 1: The Assembly Line (Generate numbers 2 to 1000)
    SELECT 2 AS num
    UNION ALL
    SELECT num + 1 
    FROM Numbers 
    WHERE num < 1000
)
-- Step 2 & 3: The Primality Filter and Output Formatter
SELECT GROUP_CONCAT(n1.num SEPARATOR '&')
FROM Numbers n1
WHERE NOT EXISTS (
    -- The Logic Gate: Check if ANY smaller number divides into it evenly
    SELECT 1 
    FROM Numbers n2 
    WHERE n2.num < n1.num 
      AND n1.num % n2.num = 0
);