SELECT 
    CASE 
        -- Rule 1: Odd number AND the very last seat (No partner)
        WHEN id % 2 = 1 AND id = (SELECT MAX(id) FROM Seat) THEN id
        
        -- Rule 2: Odd number (Has a partner)
        WHEN id % 2 = 1 THEN id + 1
        
        -- Rule 3: Even number
        ELSE id - 1
    END AS id,
    student
FROM Seat
ORDER BY id;