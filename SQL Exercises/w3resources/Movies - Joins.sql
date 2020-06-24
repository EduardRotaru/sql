
-- 1. Write a query in SQL to find the name of all reviewers who have rated their ratings with a NULL value. 
SELECT rev.rev_name
FROM reviewer rev
INNER JOIN rating rat ON rat.rev_id = rev.rev_id 
WHERE rat.rev_stars IS NULL

-- 2. Write a query in SQL to list the first and last names of all the actors who were cast in the movie 'Annie Hall', and the roles they played in that production. 
SELECT act.act_fname || ' ' || act.act_lname, mc.role       
FROM actor act
INNER JOIN movie_cast mc ON mc.act_id = act.act_id 
INNER JOIN movie m ON m.mov_id = mc.mov_id 
WHERE m.mov_title = 'Annie Hall'

-- 3. Write a query in SQL to find the name of movie and director (first and last names) who directed a movie that casted a role for 'Eyes Wide Shut'. 
SELECT dir.dir_fname || ' ' || dir.dir_lname, m.mov_title       
FROM director dir
INNER JOIN movie_direction md ON md.dir_id = dir.dir_id 
INNER JOIN movie_cast mc ON mc.mov_id = md.mov_id  
INNER JOIN movie m ON m.mov_id = mc.mov_id 
WHERE m.mov_title = 'Eyes Wide Shut'

-- 4. Write a query in SQL to find the name of movie and director (first and last names) who directed a movie that casted a role as Sean Maguire.
SELECT dir.dir_fname || ' ' || dir.dir_lname, m.mov_title       
FROM director dir
INNER JOIN movie_direction md ON md.dir_id = dir.dir_id 
INNER JOIN movie_cast mc ON mc.mov_id = md.mov_id  
INNER JOIN movie m ON m.mov_id = mc.mov_id 
WHERE mc.role = 'Sean Maguire'

-- 5. Write a query in SQL to list all the actors who have not acted in any movie between 1990 and 2000. 
SELECT act.act_fname || ' ' || act.act_lname, mc.role       
FROM actor act
INNER JOIN movie_cast mc ON mc.act_id = act.act_id 
INNER JOIN movie m ON m.mov_id = mc.mov_id 
WHERE m.mov_year NOT BETWEEN 1990 AND 2000

-- 6. Write a query in SQL to list first and last name of all the directors with number of genres movies the directed with genres name,
	-- and arranged the result alphabetically with the first and last name of the director. 
SELECT dir.dir_fname || ' ' || dir.dir_lname, COUNT(*)       
FROM director dir
INNER JOIN movie_direction md ON md.dir_id = dir.dir_id
INNER JOIN movie_genres mg ON mg.mov_id = md.mov_id  
INNER JOIN genres g ON g.gen_id  = mg.gen_id 
GROUP BY dir.dir_fname || ' ' || dir.dir_lname
ORDER BY dir.dir_fname || ' ' || dir.dir_lname

-- 7. Write a query in SQL to list all the movies with year and genres. 
SELECT m.mov_title, m.mov_year, g.gen_title                      
FROM movie m
INNER JOIN movie_genres mg ON m.mov_id = mg.mov_id 
INNER JOIN genres g ON g.gen_id = mg.gen_id 

-- 8. Write a query in SQL to list all the movies with year, genres, and name of the director. 
SELECT dir.dir_fname || ' ' || dir.dir_lname, m.mov_title, m.mov_year, g.gen_title       
FROM director dir
INNER JOIN movie_direction md ON md.dir_id = dir.dir_id 
INNER JOIN movie m ON m.mov_id = md.mov_id 
INNER JOIN movie_genres mg ON mg.mov_id = m.mov_id 
INNER JOIN genres g ON g.gen_id = mg.gen_id 

-- 9. Write a query in SQL to list all the movies with title, year, date of release, movie duration, and first and last name of the director 
	-- which released before 1st january 1989, and sort the result set according to release date from highest date to lowest. 
SELECT dir.dir_fname || ' ' || dir.dir_lname, m.*  
FROM director dir
INNER JOIN movie_direction md ON md.dir_id = dir.dir_id 
INNER JOIN movie m ON m.mov_id = md.mov_id 
WHERE m.mov_dt_rel < '1989-01-01'::date
ORDER BY m.mov_dt_rel DESC

-- 10. Write a query in SQL to compute a report which contain the genres of those movies with their average time and number of movies for each genres. 
SELECT g.gen_title, TRUNC(AVG(m.mov_time), 2), COUNT(g.gen_title)               
FROM movie m
INNER JOIN movie_genres mg ON m.mov_id = mg.mov_id 
INNER JOIN genres g ON g.gen_id = mg.gen_id 
GROUP BY g.gen_title

-- 11. Write a query in SQL to find those lowest duration movies along with the year, director's name, actor's name and his/her role in that production. 
SELECT m.mov_title,
		m.mov_year,
		mc.role,
		d.dir_fname || ' ' || d.dir_lname, 
		act.act_fname || ' ' || act.act_lname           
FROM movie m
INNER JOIN movie_direction md ON m.mov_id = md.mov_id 
INNER JOIN director d ON d.dir_id  = md.dir_id 
INNER JOIN movie_cast mc ON mc.mov_id = m.mov_id 
INNER JOIN actor act ON act.act_id  = mc.act_id  
WHERE m.mov_time =(SELECT MIN(mov_time)
				  FROM movie)

-- 12. Write a query in SQL to find all the years which produced a movie that received a rating of 3 or 4, and sort the result in increasing order.
SELECT m.mov_title, m.mov_year, r.rev_stars 
FROM movie m
INNER JOIN rating r ON r.mov_id = m.mov_id 
WHERE r.rev_stars = 3 OR r.rev_stars = 4

-- 13. Write a query in SQL to return the reviewer name, movie title, and stars 
	-- in an order that reviewer name will come first, then by movie title, and lastly by number of stars. 
SELECT r.rev_name, m.mov_title, ra.rev_stars 
FROM movie m
INNER JOIN rating ra ON ra.mov_id = m.mov_id 
INNER JOIN reviewer r ON r.rev_id = ra.rev_id  
WHERE r.rev_name IS NOT NULL 
	AND ra.rev_stars IS NOT NULL
ORDER BY r.rev_name,  m.mov_title, ra.rev_stars 

-- 14. Write a query in SQL to find movie title and number of stars for each movie 
	-- that has at least one rating and find the highest number of stars that movie received and sort the result by movie title. 
SELECT m.mov_title, ra.rev_stars, MAX(ra.rev_stars) 
FROM movie m
INNER JOIN rating ra ON ra.mov_id = m.mov_id 
WHERE ra.num_o_ratings > 1 
GROUP BY m.mov_title, ra.rev_stars
ORDER BY m.mov_title

-- 15. Write a query in SQL to find the director's first and last name together with the title of the movie(s) they directed and received the rating.
SELECT 
	d.dir_fname || ' ' || d.dir_lname, 
	m.mov_title, 
	r.rev_stars        
FROM movie m 
INNER JOIN movie_direction md ON md.mov_id = m.mov_id  
INNER JOIN director d ON d.dir_id  = md.dir_id  
INNER JOIN rating r ON r.mov_id = md.mov_id 
WHERE r.rev_stars IS NOT NULL

-- 16. Write a query in SQL to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies.
SELECT 
	a.act_fname || ' ' || a.act_lname, 
	m.mov_title, 
	mc.role        
FROM movie m 
INNER JOIN movie_cast mc ON m.mov_id = mc.mov_id 
INNER JOIN actor a ON a.act_id = mc.act_id 
WHERE a.act_id IN(SELECT act_id
				 FROM movie_cast
				 GROUP BY act_id 
				 HAVING COUNT(act_id) > 1)

-- 17. Write a query in SQL to find the first and last name of a director and the movie he or she directed, 
	-- and the actress appeared which first name was Claire and last name was Danes along with her role in that movie. 
SELECT 
	d.dir_fname || ' ' || d.dir_lname, 
	m.mov_title, 
	mc.role,   
	a.act_fname || ' ' || a.act_lname       
FROM movie m 
INNER JOIN movie_cast mc ON m.mov_id = mc.mov_id 
INNER JOIN actor a ON a.act_id = mc.act_id 
INNER JOIN movie_direction md ON m.mov_id = md.mov_id
INNER JOIN director d ON d.dir_id = md.dir_id 
WHERE a.act_fname = 'Claire' AND a.act_lname = 'Danes'

-- 18. Write a query in SQL to find the first and last name of an actor with their role in the movie which was also directed by themselve. 
SELECT 
	d.dir_fname || ' ' || d.dir_lname, 
	m.mov_title, 
	mc.role,   
	a.act_fname || ' ' || a.act_lname       
FROM movie m 
INNER JOIN movie_cast mc ON m.mov_id = mc.mov_id 
INNER JOIN actor a ON a.act_id = mc.act_id 
INNER JOIN movie_direction md ON m.mov_id = md.mov_id
INNER JOIN director d ON d.dir_id = md.dir_id 
WHERE d.dir_fname = a.act_fname 

-- 19. Write a query in SQL to find the cast list for the movie Chinatown. 
SELECT 
	m.mov_title, 
	mc.role,   
	a.act_fname || ' ' || a.act_lname       
FROM movie m 
INNER JOIN movie_cast mc ON m.mov_id = mc.mov_id 
INNER JOIN actor a ON a.act_id = mc.act_id 
WHERE m.mov_title = 'Chinatown'

-- 20. Write a query in SQL to find the movie in which the actor appeared whose first and last name are 'Harrison' and 'Ford'. 
SELECT 
	m.mov_title, 
	mc.role,   
	a.act_fname || ' ' || a.act_lname       
FROM movie m 
INNER JOIN movie_cast mc ON m.mov_id = mc.mov_id 
INNER JOIN actor a ON a.act_id = mc.act_id 
WHERE a.act_fname = 'Harrison' AND a.act_lname = 'Ford'

-- 21. Write a query in SQL to find the highest-rated movie, and report its title, year, rating, and releasing country. 
SELECT 
	m.mov_title, 
	m.mov_year,
	m.mov_rel_country,
	r.num_o_ratings,
	r.rev_stars
FROM movie m 
INNER JOIN rating r ON r.mov_id = m.mov_id 
WHERE r.rev_stars = (SELECT MAX(rev_stars)
					FROM rating)

-- 22. Write a query in SQL to find the highest-rated Mystery movie, and report the title, year, and rating.
SELECT 
	m.mov_title, 
	m.mov_year,
	m.mov_rel_country,
	r.num_o_ratings,
	r.rev_stars
FROM movie m 
INNER JOIN rating r ON r.mov_id = m.mov_id 
WHERE r.rev_stars = (SELECT MAX(r2.rev_stars)
					FROM rating r2
					INNER JOIN movie m ON r2.mov_id = m.mov_id 
					INNER JOIN movie_genres mg ON m.mov_id = mg.mov_id 
					INNER JOIN genres g ON g.gen_id = mg.gen_id 
					WHERE g.gen_title = 'Mystery') 

-- 23. Write a query in SQL to generate a report which shows the year when most of the Mystery movies produces, and number of movies and their average rating.
SELECT m.mov_year, COUNT(g.*), COUNT(m.*), AVG(r.rev_stars)
FROM movie m
INNER JOIN rating r ON r.mov_id = m.mov_id 
INNER JOIN movie_genres mg ON m.mov_id = mg.mov_id 
INNER JOIN genres g ON g.gen_id = mg.gen_id 
WHERE g.gen_title = 'Mystery'
GROUP BY m.mov_year

-- 24. Write a query in SQL to generate 
	-- a report which contain the columns movie title, name of the female actor, year of the movie, role, movie genres, the director, date of release, and rating of that movie.
SELECT
	m.mov_title,
	a.act_fname || ' ' || a.act_lname,
	m.mov_year,
	mc.role,
	g.gen_title,
	d.dir_fname || ' ' || d.dir_fname,
	m.mov_dt_rel,
	r.rev_stars 
FROM movie m
INNER JOIN rating r ON r.mov_id = m.mov_id 
INNER JOIN movie_genres mg ON m.mov_id = mg.mov_id 
INNER JOIN genres g ON g.gen_id = mg.gen_id 
INNER JOIN movie_direction md ON md.mov_id = m.mov_id
INNER JOIN director d ON d.dir_id = md.dir_id
INNER JOIN movie_cast mc ON mc.mov_id = m.mov_id
INNER JOIN actor a ON a.act_id = mc.act_id 
WHERE a.act_gender = 'F'