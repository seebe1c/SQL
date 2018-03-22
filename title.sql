SELECT title, author_lname,
CASE
    WHEN title LIKE '%stories%' THEN 'Short Stories'
    WHEN title LIKE 'Just Kids' || title LIKE '%A heartbreaking work%' THEN 'Memoirs'
    ELSE 'Novel'
END AS 'Type'
FROM books;