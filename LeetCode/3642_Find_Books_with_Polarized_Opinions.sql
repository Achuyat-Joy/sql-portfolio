WITH SessionStats AS (
    SELECT
        book_id,
        COUNT(session_id) as total_sessions,
        MAX(session_rating) as highest_rating,
        MIN(session_rating) as lowest_rating,
        SUM(CASE WHEN session_rating >= 4 THEN 1 ELSE 0 END) as high_ratings,
        SUM(CASE WHEN session_rating <= 2 THEN 1 ELSE 0 END) as low_ratings,
        SUM(CASE WHEN session_rating >= 4 OR session_rating <= 2 THEN 1 ELSE 0 END) as extreme_ratings
    FROM reading_sessions
    GROUP BY book_id
)
SELECT 
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages,
    (s.highest_rating - s.lowest_rating) as rating_spread,
    ROUND(s.extreme_ratings * 1.0 / s.total_sessions, 2) as polarization_score
FROM books b
JOIN SessionStats s ON b.book_id = s.book_id
WHERE s.total_sessions >= 5
  AND s.high_ratings >= 1
  AND s.low_ratings >= 1
  AND (s.extreme_ratings * 1.0 / s.total_sessions) >= 0.6
ORDER BY polarization_score DESC, b.title DESC;