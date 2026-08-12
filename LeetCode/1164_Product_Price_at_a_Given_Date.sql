WITH RankedPrices AS (
    -- BUCKET 1: Rank the past prices
    SELECT 
        product_id, 
        new_price, 
        ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY change_date DESC) as rn
    FROM Products
    WHERE change_date <= '2019-08-16'
)

-- Grab the #1 ranked price for the updated products
SELECT product_id, new_price AS price
FROM RankedPrices
WHERE rn = 1

UNION 

-- BUCKET 2: Grab the default products
SELECT DISTINCT product_id, 10 AS price
FROM Products
WHERE product_id NOT IN (
    SELECT product_id 
    FROM Products 
    WHERE change_date <= '2019-08-16'
);