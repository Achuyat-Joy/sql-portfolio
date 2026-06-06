-- Topic: Basic Joins

SELECT s.user_id, round(coalesce(sum(case when c.action='confirmed' then 1.0 else 0.0 end)/count(c.user_id),0),2)as confirmation_rate
FROM Signups as s
LEFT JOIN Confirmations as c
ON s.user_id = c.user_id
group by s.user_id;