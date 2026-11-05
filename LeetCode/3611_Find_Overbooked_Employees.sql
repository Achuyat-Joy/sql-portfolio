WITH WeeklyMeetingHours AS (
    -- Step 1: Crush the data into buckets by employee AND specific week
    SELECT 
        employee_id, 
        YEARWEEK(meeting_date, 1) AS week_identifier,
        SUM(duration_hours) AS total_weekly_hours
    FROM meetings
    GROUP BY employee_id, YEARWEEK(meeting_date, 1)
    HAVING SUM(duration_hours) > 20
),
HeavyWeekCounts AS (
    -- Step 2: Count how many heavy weeks each employee survived
    SELECT 
        employee_id,
        COUNT(week_identifier) AS meeting_heavy_weeks
    FROM WeeklyMeetingHours
    GROUP BY employee_id
    HAVING COUNT(week_identifier) >= 2
)
-- Step 3: Attach the descriptive labels for the final output
SELECT 
    e.employee_id,
    e.employee_name,
    e.department,
    h.meeting_heavy_weeks
FROM HeavyWeekCounts h
JOIN employees e ON h.employee_id = e.employee_id
ORDER BY h.meeting_heavy_weeks DESC, e.employee_name ASC;