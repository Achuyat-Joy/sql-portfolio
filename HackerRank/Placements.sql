SELECT Name 
FROM Students AS s

  INNER JOIN Friends AS f
  ON s.id = f.id
  
  INNER JOIN Packages AS p_student
  ON s.id = p_student.id 
  
  INNER JOIN Packages as p_friend
  on p_friend.id = f.Friend_ID
  
WHERE p_friend.salary > p_student.salary
ORDER BY p_friend.salary;