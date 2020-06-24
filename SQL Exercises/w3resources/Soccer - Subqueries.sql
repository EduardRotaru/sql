
-- 1. Write a query in SQL to find the teams played the first match of EURO cup 2016.
SELECT country_name 
FROM soccer_country
WHERE country_id IN (SELECT team_id 
				   FROM match_details 
				   WHERE match_no = 1)
				   
-- 2. Write a query in SQL to find the winner of EURO cup 2016.
SELECT country_name 
FROM soccer_country
WHERE country_id IN (SELECT team_id 
				   FROM match_details 
				   WHERE play_stage = 'F' 
					 	AND win_lose = 'W')

-- 3. Write a query in SQL to find the match with match no, play stage, goal scored, and the audience which was the heighest audience match.
SELECT match_no, play_stage, goal_score, audence 
FROM match_mast
WHERE audence = (SELECT MAX(audence)
				FROM match_mast)

-- 4. Write a query in SQL to find the match no in which Germany played against Poland 
SELECT match_no
FROM match_mast
WHERE team_id = (SELECT country_id
				FROM match_mast
				WHERE country_id )
				
-- 5. Write a query in SQL to find the match no, play stage, date of match, number of gole scored, and the result of the match where Portugal played against Hungary. 
SELECT match_no, play_stage, play_date, results, goal_score
FROM match_mast
WHERE match_no IN(SELECT match_no 
				 FROM match_details
				 WHERE team_id IN(SELECT country_id 
								 FROM soccer_country
								 WHERE country_abbr IN('POR','HUN')))
GROUP BY match_no 
HAVING COUNT(DISTINCT team_id)=2) -- using this because from the entire list of games in need to counts twice since they played same game

SELECT match_no, play_stage, play_date, results, goal_score
FROM match_mast
WHERE match_no IN(SELECT md.match_no
				 FROM match_details md
				 INNER JOIN soccer_country sc ON md.team_id = sc.country_id
				 WHERE sc.country_abbr IN('POR','HUN')
GROUP BY match_no 
HAVING COUNT(DISTINCT team_id)=2)

-- 6. Write a query in SQL to display the list of players scored number of goals in every matches.
SELECT match_no,country_name, player_name, COUNT(*)
FROM player_mast pm, goal_details gd, soccer_country sc
WHERE pm.player_id = gd.player_id 
	AND gd.team_id = sc.country_id 
GROUP BY match_no, country_name, player_name

SELECT match_no, country_name, player_name, COUNT(*)
FROM goal_details
JOIN soccer_country ON goal_details.team_id = soccer_country.country_id
JOIN player_mast ON goal_details.player_id = player_mast.player_id
GROUP BY match_no, country_name, player_name

-- 7. Write a query in SQL to find the teams who played the heighest audience match. 
SELECT *
FROM soccer_country
WHERE country_id IN(SELECT team_id 
				   FROM goal_details
				   WHERE match_no = (SELECT match_no
									FROM match_mast
									WHERE audence = (SELECT MAX(audence)
													FROM match_mast)))
					
-- 8. Write a query in SQL to find the player who scored the last goal for Portugal against Hungary.
SELECT player_name       
FROM player_mast
WHERE player_id IN (SELECT player_id 
					FROM goal_details
					WHERE match_no IN (SELECT DISTINCT match_no
										 FROM goal_details
										 WHERE goal_time IN (SELECT goal_time
															FROM goal_details 
															WHERE team_id IN(SELECT country_id 
																			FROM soccer_country
																			WHERE country_abbr IN('POR','HUN')))))

					
					
					
					
					
					
					(SELECT match_no 
									 FROM match_details
									 WHERE goal_time IN (SELECT MAX(goal_time)
														FROM goal_details
														WHERE team_id IN(SELECT country_id 
																			FROM soccer_country
																			WHERE country_name = 'Portugal' AND country_name = 'Hungary'))))
																		
				
			
-- 9. Write a query in SQL to find the 2nd highest stoppage time which had been added in 2nd half of play.
SELECT MAX(stop2_sec)
FROM match_mast
WHERE stop2_sec < (SELECT MAX(stop2_sec)
					   FROM match_mast)
					   
-- 10. Write a query in SQL to find the teams played the match where 2nd highest stoppage time had been added in 2nd half of play. 
SELECT country_name
FROM soccer_country
WHERE country_id IN(SELECT team_id 
				   FROM match_details
				   WHERE match_no = (SELECT match_no
									FROM match_mast
									WHERE stop2_sec = (SELECT MAX(stop2_sec)
													   FROM match_mast
													   WHERE stop2_sec <> (SELECT MAX(stop2_sec)
														                   FROM match_mast))))

-- 11. Write a query in SQL to find the match no, date of play and the 2nd highest stoppage time which have been added in the 2nd half of play.
SELECT match_no, play_date, MAX(stop2_sec)
FROM match_mast
WHERE stop2_sec <> (SELECT MAX(stop2_sec)
					   FROM match_mast)
GROUP BY match_no, play_date
ORDER BY MAX(stop2_sec) DESC
LIMIT 1

-- 12. Write a query in SQL to find the team which was defeated by Portugal in EURO cup 2016 final.
SELECT *
FROM soccer_country
WHERE country_id =(SELECT team_id 
				  FROM match_details
				  WHERE win_lose = 'L' AND play_stage = 'F')

-- 13. Write a query in SQL to find the club which supplied the most number of players to the 2016 EURO cup.


-- 14. Write a query in SQL to find the player and his jersey number Who scored the first penalty of the tournament.
SELECT player_name, jersey_no 
FROM player_mast
WHERE player_id = (SELECT player_id 
				  FROM goal_details
				  WHERE goal_type = 'P' AND goal_time = (SELECT MIN(goal_time)
									FROM goal_details
									WHERE goal_type = 'P' AND play_stage = 'G'))

-- 15. Write a query in SQL to find the player along with his team and jersey number who scored the first penalty of the tournament. 
	
	
-- 16. Write a query in SQL to find the player who was the goalkeeper for Italy in penalty shootout against Germany in Football EURO cup 2016.


-- 17. Write a query in SQL to find the number of Germany scored at the tournament. 


-- 18. Write a query in SQL to find the players along with their jersey no., and playing club, who were the goalkeepers for the England squad for 2016 EURO cup. 


-- 19. Write a query in SQL to find the players with other information under contract to Liverpool were in the Squad of England in 2016 EURO cup.


-- 20. Write a query in SQL to find the player with other infromation Who scored the last goal in the 2nd semi final i.e. 50th match in EURO cub 2016.


-- 21. Write a query in SQL to find the player Who was the captain of the EURO cup 2016 winning team from Portugal. 


-- 22. Write a query in SQL to find the number of players played for france in the final.


-- 23. Write a query in SQL to find the goalkeeper of the team Germany who didn't concede any goal in their group stage matches.


-- 24. Write a query in SQL to find the runners-up in Football EURO cup 2016.


-- 25. Write a query in SQL to find the maximum penalty shots taken by the teams. 


-- 26. Write a query in SQL to find the maximum number of penalty shots taken by the players.

-- #toohard
-- 27. Write a query in SQL to find the match no. where highest number of penalty shots taken.


-- 28. Write a query in SQL to find the match no. and teams who played the match where highest number of penalty shots had been taken.


-- 29. Write a query in SQL to find the player of portugal who taken the 7th kick against poland.
SELECT player_id 
FROM penalty_shootout
WHERE kick_no = 7 AND team_id IN(SELECT country_id 
				FROM soccer_country
				WHERE country_name IN('Portugal','Poland'))

-- 30. Write a query in SQL to find the stage of match where the penalty kick number 23 had been taken.
SELECT *  
FROM match_mast
WHERE decided_by = 'P' 
	AND match_no IN(SELECT match_no
				   FROM penalty_shootout
				   WHERE kick_id = 23)

-- 31. Write a query in SQL to find the venues where penalty shootout matches played.
SELECT *
FROM soccer_venue
WHERE venue_id IN(SELECT venue_id 
				 FROM match_mast 
				 WHERE decided_by = 'P' 
				  	AND match_no IN(SELECT match_no
				  					FROM penalty_shootout))

-- 32. Write a query in SQL to find the date when penalty shootout matches played.
SELECT play_date  
FROM match_mast
WHERE decided_by = 'P' 
	AND match_no IN(SELECT match_no
				   FROM penalty_shootout)

-- 33. Write a query in SQL to find the most quickest goal at the EURO cup 2016, after 5 minutes.
SELECT goal_id 
FROM goal_details
WHERE goal_time = (SELECT MIN(goal_time)
				  FROM goal_details
				  WHERE goal_time > 5)
