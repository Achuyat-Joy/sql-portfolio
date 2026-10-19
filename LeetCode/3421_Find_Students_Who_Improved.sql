WITH RankedExams AS (
    SELECT 
        student_id, 
        subject, 
        score,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date ASC) AS first_exam,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date DESC) AS latest_exam
    FROM Scores
)
SELECT 
    student_id, 
    subject, 
    SUM(CASE WHEN first_exam = 1 THEN score END) AS first_score,
    SUM(CASE WHEN latest_exam = 1 THEN score END) AS latest_score
FROM RankedExams
GROUP BY student_id, subject
HAVING COUNT(*) > 1 
   AND SUM(CASE WHEN latest_exam = 1 THEN score END) > SUM(CASE WHEN first_exam = 1 THEN score END)
ORDER BY student_id, subject;