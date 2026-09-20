SELECT score, dense_rank() over(order by score desc) AS `rank`
FROM Scores;