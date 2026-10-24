WITH ActiveBorrows AS (
    -- Step 1: Count active checkouts using ONLY the records table
    SELECT 
        book_id, 
        COUNT(book_id) AS current_borrowers
    FROM borrowing_records
    WHERE return_date IS NULL
    GROUP BY book_id
)

-- Step 2: Join to the library and compare inventory
SELECT 
    l.book_id, 
    l.title, 
    l.author, 
    l.genre, 
    l.publication_year,
    b.current_borrowers 
FROM library_books AS l
JOIN ActiveBorrows AS b 
    ON l.book_id = b.book_id
WHERE b.current_borrowers = l.total_copies
ORDER BY b.current_borrowers DESC, l.title ASC;