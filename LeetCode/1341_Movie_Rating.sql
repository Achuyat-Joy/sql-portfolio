(
    -- BUCKET 1: The User with the most ratings
    SELECT u.name AS results
    FROM MovieRating AS mr
    LEFT JOIN Users AS u 
        ON mr.user_id = u.user_id
    GROUP BY u.user_id, u.name
    ORDER BY COUNT(mr.movie_id) DESC, u.name ASC
    LIMIT 1
)

UNION ALL 

(
    -- BUCKET 2: The highest rated movie in Feb 2020
    SELECT m.title AS results
    FROM MovieRating AS mr
    LEFT JOIN Movies AS m 
        ON mr.movie_id = m.movie_id
    WHERE mr.created_at LIKE '2020-02%'
    GROUP BY m.movie_id, m.title
    ORDER BY AVG(mr.rating) DESC, m.title ASC
    LIMIT 1
);