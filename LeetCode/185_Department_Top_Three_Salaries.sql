WITH RankedEmployees AS (
    -- Machine 1: Join the tables and rank the salaries
    SELECT 
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER(
            PARTITION BY e.departmentId 
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM Employee e
    JOIN Department d 
        ON e.departmentId = d.id
)

-- Machine 2: Filter for the top 3!
SELECT 
    Department, 
    Employee, 
    Salary
FROM RankedEmployees
WHERE salary_rank <= 3;