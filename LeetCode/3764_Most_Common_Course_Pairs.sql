WITH UserCourses AS (
    -- Step 1: Pair each course with the very next course and stamp student-level stats
    SELECT 
        course_name AS first_course,
        LEAD(course_name) OVER(
            PARTITION BY user_id 
            ORDER BY completion_date ASC, course_id ASC
        ) AS second_course,
        COUNT(*) OVER(PARTITION BY user_id) AS total_courses,
        AVG(course_rating) OVER(PARTITION BY user_id) AS avg_rating
    FROM course_completions
)
-- Step 2: Filter for top performers, drop the dead-end final course, and tally pairs
SELECT 
    first_course,
    second_course,
    COUNT(*) AS transition_count
FROM UserCourses
WHERE total_courses >= 5
  AND avg_rating >= 4.0
  AND second_course IS NOT NULL
GROUP BY first_course, second_course
ORDER BY 
    transition_count DESC, 
    first_course ASC, 
    second_course ASC;