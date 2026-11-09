SELECT 
    customer_id,
    COUNT(*) AS total_orders,
    ROUND(SUM(CASE WHEN HOUR(order_timestamp) BETWEEN 11 AND 13 OR HOUR(order_timestamp) BETWEEN 18 AND 20 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 0) AS peak_hour_percentage,
    ROUND(AVG(order_rating), 2) AS average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING 
    COUNT(*) >= 3
    AND (SUM(CASE WHEN HOUR(order_timestamp) BETWEEN 11 AND 13 OR HOUR(order_timestamp) BETWEEN 18 AND 20 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) >= 60
    AND (COUNT(order_rating) * 100.0 / COUNT(*)) >= 50
    AND AVG(order_rating) >= 4.0
ORDER BY 
    average_rating DESC, 
    customer_id DESC;