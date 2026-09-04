WITH RankedStations AS (
    -- Step 1: The Assembly Line (Sorting and Counting)
    SELECT 
        LAT_N,
        ROW_NUMBER() OVER (ORDER BY LAT_N) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM STATION
)
-- Step 2: The Math (Extracting the Middle)
SELECT ROUND(AVG(LAT_N), 4)
FROM RankedStations
WHERE row_num IN (
    FLOOR((total_rows + 1) / 2), 
    CEIL((total_rows + 1) / 2)
);