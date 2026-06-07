-- Topic: Basic Aggregate Functions

SELECT *
FROM Cinema
WHERE description!='boring' and id%2!=0
ORDER BY rating desc;