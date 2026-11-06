WITH RankedInventory AS (
    -- Step 1: Hand out ranking tickets and count total products per store
    SELECT 
        store_id,
        product_name,
        quantity,
        ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY price ASC) AS rank_cheap,
        ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY price DESC) AS rank_exp,
        COUNT(*) OVER(PARTITION BY store_id) AS total_products
    FROM inventory
),
PivotedExtremes AS (
    -- Step 2: Filter low-inventory stores and pivot the extreme ends onto one row
    SELECT 
        store_id,
        MAX(CASE WHEN rank_exp = 1 THEN product_name END) AS most_exp_product,
        MAX(CASE WHEN rank_exp = 1 THEN quantity END) AS most_exp_qty,
        MAX(CASE WHEN rank_cheap = 1 THEN product_name END) AS cheapest_product,
        MAX(CASE WHEN rank_cheap = 1 THEN quantity END) AS cheapest_qty
    FROM RankedInventory
    WHERE total_products >= 3
    GROUP BY store_id
)
-- Step 3: Check the math, attach store details, and calculate the ratio
SELECT 
    s.store_id,
    s.store_name,
    s.location,
    p.most_exp_product,
    p.cheapest_product,
    ROUND(p.cheapest_qty / NULLIF(p.most_exp_qty, 0), 2) AS imbalance_ratio
FROM stores s
JOIN PivotedExtremes p ON s.store_id = p.store_id
WHERE p.most_exp_qty < p.cheapest_qty
ORDER BY imbalance_ratio DESC, s.store_name ASC;