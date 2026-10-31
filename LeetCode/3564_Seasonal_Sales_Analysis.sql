WITH SeasonData AS (
    -- Step 1: Assign seasons and calculate individual row revenue
    SELECT 
        p.category,
        s.quantity,
        (s.quantity * s.price) AS revenue,
        CASE 
            WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(s.sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(s.sale_date) IN (6, 7, 8) THEN 'Summer'
            WHEN MONTH(s.sale_date) IN (9, 10, 11) THEN 'Fall'
        END AS season
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
),
CategoryAgg AS (
    -- Step 2: Crush the data into buckets by season and category
    SELECT 
        season,
        category,
        SUM(quantity) AS total_quantity,
        SUM(revenue) AS total_revenue
    FROM SeasonData
    GROUP BY season, category
),
RankedCategories AS (
    -- Step 3: Hand out strictly ordered ranking tickets per season
    SELECT 
        season,
        category,
        total_quantity,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY season 
            ORDER BY total_quantity DESC, total_revenue DESC, category ASC
        ) AS rank_num
    FROM CategoryAgg
)
-- Step 4: Keep only the winners and sort the final output
SELECT 
    season,
    category,
    total_quantity,
    total_revenue
FROM RankedCategories
WHERE rank_num = 1
ORDER BY season ASC;