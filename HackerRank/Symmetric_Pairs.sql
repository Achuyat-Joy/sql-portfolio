-- Scenario 1: Standard Symmetric Pairs (where X is less than Y)
SELECT f1.X, f1.Y
FROM Functions f1
JOIN Functions f2 
    ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.X < f1.Y

UNION

-- Scenario 2: The Identity Trap (where X and Y are exactly the same)
SELECT X, Y
FROM Functions
WHERE X = Y
GROUP BY X, Y
HAVING COUNT(*) > 1

ORDER BY X ASC;