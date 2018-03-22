-- 1. Find 5 oldest users

SELECT * FROM users
ORDER BY created_at LIMIT 5;

-- 2. Best day of the week people tend to register

SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

-- 3. Target inactive users = never posted a picture

SELECT username, image_url
    FROM users
    LEFT JOIN photos
    ON users.id = photos.user_id
    WHERE ISNULL(image_url);

-- 4. Most likes on a single photo - who won?

SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- 5. How many times does the average user post?

SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) from users);

-- 6 most popular hashtags

SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5;

-- Find users who could be bots - i.e. liked all the photo's on the site

SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos);