WITH sumOfDistance AS (
    SELECT user_id, sum(distance) as travelled_distance
    FROM Rides 
    GROUP BY user_id
)

SELECT u.name, coalesce(travelled_distance,0) as travelled_distance
FROM sumOfDistance
RIGHT JOIN Users as u
    on u.id = sumOfDistance.user_id
ORDER BY travelled_distance desc, name;