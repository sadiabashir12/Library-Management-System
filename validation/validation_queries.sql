-- Row count check
SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM members;
SELECT COUNT(*) FROM issues;

-- NULL check
SELECT * FROM books WHERE book_id IS NULL;
SELECT * FROM issues WHERE member_id IS NULL OR book_id IS NULL;

-- FK integrity check
SELECT i.*
FROM issues i
LEFT JOIN books b ON i.book_id = b.book_id
WHERE b.book_id IS NULL;

-- UPDATE example
UPDATE issues
SET returned = 1
WHERE issue_id = 5;

-- DELETE example
DELETE FROM issues
WHERE issue_id = 10;