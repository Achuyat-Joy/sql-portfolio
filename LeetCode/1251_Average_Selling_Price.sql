-- Topic: Basic Aggregate Functions

SELECT p.product_id, coalesce(round(sum(p.price * u.units) / sum(u.units),2),0) as average_price
FROM Prices as p
LEFT JOIN UnitsSold as u
ON p.product_id = u.product_id
and u.purchase_date between p.start_date and p.end_date
group by p.product_id;