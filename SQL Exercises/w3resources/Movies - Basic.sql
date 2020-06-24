-- 1. Write a query in SQL to find the name and year of the movies.
SELECT mov_title, mov_year                       
FROM movie

-- 2. Write a query in SQL to find the year when the movie American Beauty released. 
SELECT mov_title, mov_year   
FROM movie
WHERE mov_title = 'American Beauty'

-- 3. Write a query in SQL to find the movie which was released in the year 1999.
SELECT mov_title, mov_year   
FROM movie
WHERE mov_year = 1999

-- 4. Write a query in SQL to find the movies which was released before 1998.
SELECT mov_title, mov_year   
FROM movie
WHERE mov_year < 1998
ORDER BY mov_year DESC

-- 5. Write a query in SQL to return the name of all reviewers and name of movies together in a single list. 
SELECT * 
FROM movie, reviewer

-- 6. Write a query in SQL to find the name of all reviewers who have rated 7 or more stars to their rating.
SELECT * 
FROM reviewer re
INNER JOIN rating ra ON ra.rev_id = re.rev_id
WHERE ra.rev_stars >= 7 AND re.rev_name IS NOT NULL

-- 7. Write a query in SQL to find the titles of all movies that have no ratings. 
SELECT * 
FROM movie re
LEFT JOIN rating ra ON ra.mov_id  = re.mov_id 
WHERE ra.rev_stars IS NULL

-- 8. Write a query in SQL to find the titles of the movies with ID 905, 907, 917.
SELECT * 
FROM movie 
WHERE mov_id IN(905, 907, 917)

-- 9. Write a query in SQL to find the list of all those movies with year which include the words Boogie Nights. 
SELECT * 
FROM movie 
WHERE mov_title = 'Boogie Nights'

-- 10. Write a query in SQL to find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'. 
SELECT * 
FROM actor 
WHERE act_fname = 'Woody' AND act_lname = 'Allen'    