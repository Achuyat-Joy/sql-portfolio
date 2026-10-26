SELECT transaction_date,
sum(case when amount%2!=0 then amount else 0 end) AS odd_sum, 
sum(case when amount%2=0 then amount else 0 end) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;