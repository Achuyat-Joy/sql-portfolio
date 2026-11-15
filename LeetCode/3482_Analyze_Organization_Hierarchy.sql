WITH RECURSIVE Hierarchy AS (
    -- Step 1: Top-down traversal to calculate the organizational level
    SELECT 
        employee_id, 
        employee_name, 
        1 AS level
    FROM Employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    SELECT 
        e.employee_id, 
        e.employee_name, 
        h.level + 1
    FROM Employees e
    JOIN Hierarchy h ON e.manager_id = h.employee_id
),
OrgChart AS (
    -- Step 2: Build a master map connecting every manager to all their descendants
    SELECT 
        employee_id AS ancestor_id, 
        employee_id AS descendant_id, 
        salary
    FROM Employees
    
    UNION ALL
    
    SELECT 
        o.ancestor_id, 
        e.employee_id, 
        e.salary
    FROM OrgChart o
    JOIN Employees e ON o.descendant_id = e.manager_id
),
AggregatedStats AS (
    -- Step 3: Crush the map into totals for team size and budget
    SELECT 
        ancestor_id,
        COUNT(descendant_id) - 1 AS team_size,
        SUM(salary) AS budget
    FROM OrgChart
    GROUP BY ancestor_id
)
-- Step 4: Attach the levels to the aggregates and sort
SELECT 
    h.employee_id,
    h.employee_name,
    h.level,
    a.team_size,
    a.budget
FROM Hierarchy h
JOIN AggregatedStats a ON h.employee_id = a.ancestor_id
ORDER BY 
    h.level ASC, 
    a.budget DESC, 
    h.employee_name ASC;