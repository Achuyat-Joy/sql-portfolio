-- Topic: SELECT

SELECT v.customer_id, COUNT(t.transaction_id is null) AS count_no_trans
FROM Visits AS v
LEFT JOIN Transactions AS t
ON v.visit_id = t.visit_id
WHERE t.transaction_id is null
GROUP BY v.customer_id;