SELECT 
    s.Start_Date, 
    MIN(e.End_Date) AS End_Date
FROM 
    -- Step 1: Find all True Start Dates
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) s
JOIN 
    -- Step 2: Find all True End Dates
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) e
    ON s.Start_Date < e.End_Date
-- Step 3: Match them up and sort
GROUP BY s.Start_Date
ORDER BY DATEDIFF(MIN(e.End_Date), s.Start_Date) ASC, s.Start_Date ASC;