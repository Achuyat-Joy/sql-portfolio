create database if not exists nov15;
use nov15;

create table orders(
	order_id INT,
    order_date DATE,
    customer_id INT,
    status VARCHAR(20),
    total_amount DECIMAL(10,2)
);

INSERT INTO orders 
(order_id, order_date, customer_id, status, total_amount) 
VALUES
(101, '2026-01-05', 20, 'Completed', 1500),
(102, '2026-01-06', 21, 'Completed', 2500),
(103, '2026-01-07', 20, 'Cancelled', 1200),
(104, '2026-02-02', 22, 'Completed', 3000),
(105, '2026-02-05', 21, 'Completed', 1000),
(106, '2026-02-08', 23, 'Refunded', 2000),
(107, '2026-03-01', 20, 'Completed', 1800),
(108, '2026-03-03', 24, 'Completed', 2200);

SELECT 
    MONTHNAME(order_date) AS 'Month',
    SUM(total_amount) AS 'Total Sale',
    COUNT(order_id) AS 'Number of Orders'
FROM orders
WHERE status = 'Completed'
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);