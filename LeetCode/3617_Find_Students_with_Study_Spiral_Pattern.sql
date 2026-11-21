WITH OrderedSessions AS (
    -- Step 1: Order each student's sessions and measure the gap from the previous session
    SELECT 
        student_id,
        subject,
        hours_studied,
        ROW_NUMBER() OVER(PARTITION BY student_id ORDER BY session_date, session_id) AS rn,
        DATEDIFF(
            session_date, 
            LAG(session_date) OVER(PARTITION BY student_id ORDER BY session_date, session_id)
        ) AS day_gap
    FROM study_sessions
),
StudentSummary AS (
    -- Step 2: Filter students who have >= 3 subjects, >= 2 full cycles, and NO gaps > 2 days
    SELECT 
        student_id,
        COUNT(DISTINCT subject) AS cycle_length,
        SUM(hours_studied) AS total_study_hours
    FROM OrderedSessions
    GROUP BY student_id
    HAVING COUNT(DISTINCT subject) >= 3
       AND COUNT(*) >= 2 * COUNT(DISTINCT subject)
       AND MAX(COALESCE(day_gap, 0)) <= 2
),
CycleCheck AS (
    -- Step 3: Verify that every slot in the repeating cycle always has the exact same subject
    SELECT 
        o.student_id,
        s.cycle_length,
        s.total_study_hours,
        (o.rn - 1) % s.cycle_length AS cycle_pos,
        COUNT(DISTINCT o.subject) AS subjects_at_pos
    FROM OrderedSessions o
    JOIN StudentSummary s ON o.student_id = s.student_id
    GROUP BY o.student_id, s.cycle_length, s.total_study_hours, (o.rn - 1) % s.cycle_length
)
-- Step 4: Keep only students whose repeating cycle is 100% consistent
SELECT 
    st.student_id,
    st.student_name,
    st.major,
    c.cycle_length,
    c.total_study_hours
FROM CycleCheck c
JOIN students st ON c.student_id = st.student_id
GROUP BY st.student_id, st.student_name, st.major, c.cycle_length, c.total_study_hours
HAVING MAX(c.subjects_at_pos) = 1
ORDER BY 
    c.cycle_length DESC, 
    c.total_study_hours DESC;