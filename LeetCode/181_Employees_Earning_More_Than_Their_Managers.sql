SELECT e2.name AS Employee
FROM Employee AS e1
    JOIN Employee AS e2
    ON e1.id=e2.managerId
WHERE e2.salary>e1.salary;