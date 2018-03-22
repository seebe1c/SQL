SELECT UPPER(CONCAT('My fvorite author is ', author_fname, ' ', author_lname, '!'))
    AS 'Yell'
    FROM books
    ORDER BY author_lname;