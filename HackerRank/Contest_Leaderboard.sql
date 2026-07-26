SELECT 
    h.hacker_id, h.name, 
    SUM(max_scores.best_score) AS total_score
FROM Hackers AS h
INNER JOIN (SELECT hacker_id, challenge_id, 
        MAX(score) AS best_score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
) AS max_scores 
ON h.hacker_id = max_scores.hacker_id
GROUP BY h.hacker_id, h.name
HAVING SUM(max_scores.best_score) > 0
ORDER BY total_score DESC, h.hacker_id ASC;