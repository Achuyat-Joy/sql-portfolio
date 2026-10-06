WITH higherAmount AS (
    SELECT account, sum(amount) AS balance
    FROM Transactions 
    GROUP BY account
)

SELECT u.name, balance
FROM higherAmount
JOIN Users as u
    ON u.account = higherAmount.account
WHERE balance>10000;