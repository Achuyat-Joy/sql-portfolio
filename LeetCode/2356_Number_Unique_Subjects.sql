-- Topic: Basic Joins

SELECT teacher_id, count(distinct subject_id) as cnt
FROM Teacher
GROUP BY teacher_id;