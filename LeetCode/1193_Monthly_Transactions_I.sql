-- Topic: Basic Aggregate Functions

SELECT LEFT(trans_date, 7) AS month, country,
COUNT(state) AS trans_count, 
SUM(case when state='approved' then 1 else 0 end) AS approved_count,
SUM(amount) AS trans_total_amount, 
SUM(case when state='approved' then amount else 0 end) AS approved_total_amount
FROM Transactions
GROUP BY LEFT(trans_date, 7), country;