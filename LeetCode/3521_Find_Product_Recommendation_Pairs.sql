WITH PairedPurchases AS (
    -- Step 1: Find valid product pairs and count the customers
    SELECT 
        p1.product_id AS product1_id,
        p2.product_id AS product2_id,
        COUNT(p1.user_id) AS customer_count
    FROM ProductPurchases p1
    JOIN ProductPurchases p2 
        ON p1.user_id = p2.user_id 
        AND p1.product_id < p2.product_id
    GROUP BY p1.product_id, p2.product_id
    HAVING COUNT(p1.user_id) >= 3
)

-- Step 2: Attach the category details for both products
SELECT 
    pp.product1_id,
    pp.product2_id,
    i1.category AS product1_category,
    i2.category AS product2_category,
    pp.customer_count
FROM PairedPurchases pp
JOIN ProductInfo i1 ON pp.product1_id = i1.product_id
JOIN ProductInfo i2 ON pp.product2_id = i2.product_id
ORDER BY 
    pp.customer_count DESC, 
    pp.product1_id ASC, 
    pp.product2_id ASC;