WITH UserCategories AS (
    -- Step 1: Map each user to the unique categories they purchased from
    SELECT DISTINCT 
        p.user_id,
        i.category
    FROM ProductPurchases p
    JOIN ProductInfo i ON p.product_id = i.product_id
)
-- Step 2: Self-join to pair up categories for the same user and count them
SELECT 
    c1.category AS category1,
    c2.category AS category2,
    COUNT(c1.user_id) AS customer_count
FROM UserCategories c1
JOIN UserCategories c2 
    ON c1.user_id = c2.user_id 
   AND c1.category < c2.category
GROUP BY c1.category, c2.category
HAVING COUNT(c1.user_id) >= 3
ORDER BY 
    customer_count DESC, 
    category1 ASC, 
    category2 ASC;