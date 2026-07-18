SELECT max(salary), count(name)
FROM employee
WHERE salary = (SELECT max(salary) FROM employee);

