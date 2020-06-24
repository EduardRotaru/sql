
-- 1. Write a query in SQL to list all the information of the actors who played a role in the movie 'Annie Hall'.  
SELECT *
FROM actor
WHERE act_id =(SELECT act_id 
			  FROM movie_cast	
			  WHERE mov_id = (SELECT mov_id 
							 FROM movie
							 WHERE mov_title = 'Annie Hall'))

-- 2. Write a query in SQL to find the name of the director (first and last names) who directed a movie that casted a role for 'Eyes Wide Shut'. (using subquery)
SELECT dir_fname, dir_lname
FROM director
WHERE dir_id = (SELECT dir_id 
				FROM movie_direction
			   	WHERE mov_id = (SELECT mov_id
							   FROM movie_cast
							   WHERE mov_id =(SELECT mov_id 
											 FROM movie
											 WHERE mov_title = 'Eyes Wide Shut')))

-- 3. Write a query in SQL to list all the movies which released in the country other than UK. 
SELECT * 
FROM movie
WHERE movie_id = (SELECT movie_id
				 FROM movie
				 WHERE mov_rel_country <> 'UK')
				 
-- 4. Write a query in SQL to find the movie title, year, date of release, director and actor for those movies which reviewer is unknown. 
-- Solution is cheating and filthy. 
-- Ok mine is filthy too
DROP FUNCTION GetMovieIDAndDirectorIDWhereReviwerNameIsNULL();
CREATE OR REPLACE FUNCTION GetMovieIDAndDirectorIDWhereReviwerNameIsNULL()
RETURNS TABLE (director_id integer, movie_id integer, actor_id integer, movie2_id integer) AS $$
BEGIN
	RETURN QUERY 
    (SELECT * 
	FROM (SELECT *
		 FROM movie_direction
		 WHERE mov_id IN (SELECT mov_id
						FROM movie
						WHERE mov_id IN (SELECT mov_id
										FROM movie_cast
										WHERE mov_id IN(SELECT mov_id 
													   FROM rating
													   WHERE rev_id IN(SELECT rev_id 
																	  FROM reviewer
																	  WHERE rev_name IS NULL))))) md
	INNER JOIN (SELECT act_id, mov_id AS mov_id2 
				FROM movie_cast
				WHERE act_id IN(SELECT act_id 
							   FROM actor)) AS ac ON ac.mov_id2 = md.mov_id);
	
END;
$$ LANGUAGE plpgsql;

SELECT 
	mov.mov_title,
	mov.mov_year, 
	mov.mov_dt_rel,
	dir.dir_fname || ' ' || dir.dir_lname AS director,
	act.act_fname || ' ' || act.act_lname AS actor
FROM GetMovieIDAndDirectorIDWhereReviwerNameIsNULL() AS movDir
INNER JOIN movie mov ON mov.mov_id = movDir.movie_id
INNER JOIN director dir ON dir.dir_id = movDir.director_id
INNER JOIN actor act ON act.act_id = movDir.actor_id
										  																		  
-- 5. Write a query in SQL to find the titles of all movies directed by the director whose first and last name are Woddy Allen. 
SELECT *
FROM movie
WHERE mov_id IN(SELECT mov_id
			   FROM movie_direction
			   WHERE dir_id IN(SELECT dir_id
							  FROM director
							  WHERE dir_fname = 'Woody' 
							   		AND dir_lname = 'Allen'))

-- 6. Write a query in SQL to find all the years which produced at least one movie and that received a rating of more than 3 stars. Show the results in increasing order.
SELECT mov_year 
FROM movie
WHERE mov_id IN(SELECT mov_id
			   FROM rating
			   WHERE rev_stars > 3)
ORDER BY mov_year

SELECT mov_year
FROM movie
WHERE mov_id IN(SELECT mov_id
			   FROM rating
			   WHERE rev_stars > 3)
GROUP BY mov_year
HAVING COUNT(*) >=1
ORDER BY mov_year

-- 7. Write a query in SQL to find the titles of all movies that have no ratings. 
SELECT * 
FROM movie
WHERE mov_id IN(SELECT mov_id
			   FROM rating
			   WHERE num_o_ratings IS NULL)
			   
SELECT *
FROM movie
WHERE mov_id NOT IN(SELECT mov_id
				   FROM rating)

-- 8. Write a query in SQL to find the names of all reviewers who have ratings with a NULL value.
SELECT * 
FROM reviewer
WHERE rev_id IN(SELECT rev_id
			   FROM rating
			   WHERE rev_stars IS NULL)

-- 9. Write a query in SQL to return the reviewer name, movie title, and stars for those movies which reviewed by a reviewer and must be rated. 
	-- Sort the result by reviewer name, movie title, and number of stars.
SELECT rev.rev_name, mov.mov_title, rat.rev_stars 
FROM reviewer rev
INNER JOIN rating rat ON rev.rev_id = rat.rev_id 
INNER JOIN movie mov ON mov.mov_id = rat.mov_id 
WHERE rat.rev_stars IS NOT NULL 
	AND rev.rev_name IS NOT NULL
ORDER BY rev.rev_name, mov.mov_title, rat.rev_stars 

-- 10. Write a query in SQL to find the reviewer's name and the title of the movie for those reviewers who rated more than one movies. 

SELECT mov.mov_title, rev.rev_name
FROM movie mov
INNER JOIN rating rat ON mov.mov_id = rat.mov_id 
INNER JOIN reviewer rev ON rat.rev_id = rev.rev_id 
WHERE rev.rev_id IN(SELECT rev_id
				   FROM rating
				   GROUP BY rev_id
				   HAVING COUNT(rev_id) > 1) 

-- 11. Write a query in SQL to find the movie title, and the highest number of stars that movie received 
	-- and arranged the result according to the group of a movie and the movie title appear alphabetically in ascending order.
SELECT mov.mov_title, MAX(num_o_ratings)
FROM movie mov
INNER JOIN rating rat ON mov.mov_id = rat.mov_id
WHERE rat.num_o_ratings IS NOT NULL
GROUP BY mov.mov_title
ORDER BY MAX(num_o_ratings) DESC

-- 12. Write a query in SQL to find the names of all reviewers who rated the movie American Beauty. 
SELECT rev_name
FROM reviewer
WHERE rev_id IN (SELECT rev_id 
				FROM rating
				WHERE mov_id IN(SELECT mov_id 
								FROM movie
								WHERE mov_title = 'American Beauty'))

-- 13. Write a query in SQL to find the titles of all movies which have been reviewed by anybody except by Paul Monks. 
SELECT mov_title                      
FROM movie
WHERE mov_id IN(SELECT mov_id 
			   FROM rating
			   WHERE rev_id NOT IN(SELECT rev_id 
							  FROM reviewer
							  WHERE rev_name = 'Paul Monks'))

-- 14. Write a query in SQL to return the reviewer name, movie title, and number of stars for those movies which rating is the lowest one.
SELECT rev.rev_name, mov.mov_title, rat.num_o_ratings
FROM reviewer rev
INNER JOIN rating rat ON rev.rev_id = rat.rev_id 
INNER JOIN movie mov ON rat.mov_id = mov.mov_id 
WHERE rev_stars IS NOT NULL 
	AND num_o_ratings IS NOT NULL
	AND rat.rev_stars IN(SELECT MIN(rev_stars)
						FROM rating)


-- 15. Write a query in SQL to find the titles of all movies directed by James Cameron. 
SELECT mov_title                      
FROM movie
WHERE mov_id IN(SELECT mov_id
			    FROM movie_direction 
			   WHERE dir_id IN(SELECT dir_id
							  FROM director
							  WHERE dir_fname = 'James'
							  		AND dir_lname = 'Cameron'))

-- 16. Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies. 
SELECT *
FROM movie
WHERE mov_id IN(SELECT mov_id
			   FROM movie_cast
			   WHERE act_id IN(SELECT act_id
							  FROM actor
							  WHERE act_id IN(SELECT act_id
											 FROM movie_cast
											 GROUP BY act_id
											 HAVING COUNT(act_id) > 1)))