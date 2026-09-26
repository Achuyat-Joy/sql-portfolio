SELECT name
FROM SalesPerson
WHERE sales_id NOT IN (
    -- Step 1: Build the Blacklist (Find everyone who DID sell to RED)
    SELECT o.sales_id
    FROM Orders o
    JOIN Company c 
        ON o.com_id = c.com_id
    WHERE c.name = 'RED'
);
