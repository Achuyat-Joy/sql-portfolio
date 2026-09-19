CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      WITH RankedSalaries AS (
          -- Step 1: The Assembly Line (Rank every distinct salary)
          SELECT 
              salary, 
              DENSE_RANK() OVER (ORDER BY salary DESC) AS rank_num
          FROM Employee
      )
      -- Step 2: The Filter (Extract the exact rank requested)
      SELECT MAX(salary)
      FROM RankedSalaries
      WHERE rank_num = N
  );
END