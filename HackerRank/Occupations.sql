WITH RankedOccupations AS (
    -- Step 1: The Assembly Line (Assign a row number to each name)
    SELECT 
        Name,
        Occupation,
        ROW_NUMBER() OVER (
            PARTITION BY Occupation 
            ORDER BY Name ASC
        ) AS row_num
    FROM OCCUPATIONS
)
-- Step 2: The Pivot (Move rows into columns)
SELECT 
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
FROM RankedOccupations
GROUP BY row_num;