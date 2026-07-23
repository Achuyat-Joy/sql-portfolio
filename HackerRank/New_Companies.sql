SELECT distinct c.company_code, c.founder, 
count(distinct l.lead_manager_code), count(distinct s.senior_manager_code),
count(distinct m.manager_code), count(distinct e.employee_code)
FROM Company AS c
INNER JOIN Lead_Manager AS l
  ON c.company_code = l.company_code
INNER JOIN Senior_Manager AS s
  ON s.company_code = l.company_code
INNER JOIN Manager AS m
  ON m.company_code = l.company_code
INNER JOIN Employee AS e
  ON e.company_code = m.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;
