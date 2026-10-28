SELECT user_id,
ROUND(AVG(CASE WHEN activity_type = 'free_trial' then activity_duration end),2) AS trial_avg_duration,
ROUND(AVG(CASE WHEN activity_type = 'paid' then activity_duration end),2) AS paid_avg_duration
FROM UserActivity
GROUP BY user_id
HAVING trial_avg_duration is not null and paid_avg_duration is not null
ORDER BY user_id;