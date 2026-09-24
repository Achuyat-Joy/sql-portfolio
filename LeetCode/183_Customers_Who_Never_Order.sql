SELECT name AS Customers 
FROM Customers 
WHERE id not in (select customerId from Orders);