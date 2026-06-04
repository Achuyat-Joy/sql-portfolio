-- Topic: Basic Joins

SELECT st.student_id, st.student_name, sb.subject_name, count(e.student_id) as attended_exams
FROM Students as st
CROSS JOIN Subjects as sb
LEFT JOIN Examinations as e
ON st.student_id = e.student_id 
AND sb.subject_name = e.subject_name
group by st.student_id,st.student_name, sb.subject_name
order by st.student_id, sb.subject_name;