-- Topic: Basic Aggregate Functions

SELECT p.project_id, round(sum(e.experience_years)/count(p.project_id),2) AS average_years
FROM Project AS p
LEFT JOIN Employee AS e
ON p.employee_id = e.employee_id
GROUP BY p.project_id;