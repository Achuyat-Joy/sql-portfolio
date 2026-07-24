SELECT
CASE
    WHEN g.Grade>=8 THEN s.Name
    ELSE null
END, 
Grade, Marks
FROM Students s
CROSS JOIN Grades g
WHERE s.Marks between g.Min_Mark and g.Max_Mark
ORDER BY g.Grade DESC, s.Name ASC, s.Marks;