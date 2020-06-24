
-- 1. Write a query in SQL to find the number of venues for EURO cup 2016. 
SELECT COUNT(venue_id)
FROM soccer_venue

-- 2. Write a query in SQL to find the number countries participated in the EURO cup 2016. 
SELECT COUNT(DISTINCT team_id)
FROM player_mast

-- 3. Write a query in SQL to find the number goals scored in EURO cup 2016 within normal play schedule. 
SELECT COUNT(*)
FROM goal_details
WHERE goal_schedule = 'NT'

-- 4. Write a query in SQL to find the number of matches ended with a result.
SELECT COUNT(*)
FROM match_mast
WHERE results <> 'DRAW'

-- 5. Write a query in SQL to find the number of matches ended with draws. 
SELECT COUNT(*)
FROM match_mast
WHERE results = 'WIN'

-- 6. Write a query in SQL to find the date when did Football EURO cup 2016 begin. 
SELECT play_date
FROM match_mast
ORDER BY play_date 
LIMIT 1

SELECT MIN(play_date)
FROM match_mast

-- 7. Write a query in SQL to find the number of self-goals scored in EURO cup 2016.
SELECT COUNT(*)
FROM goal_details
WHERE goal_type = 'O'

-- 8. Write a query in SQL to count the number of matches ended with a results in group stage. 
SELECT COUNT(*)
FROM match_mast
WHERE play_stage = 'G' AND results = 'WIN'

-- 9. Write a query in SQL to find the number of matches got a result by penalty shootout.  
SELECT COUNT(DISTINCT match_no)
FROM penalty_shootout

-- 10. Write a query in SQL to find the number of matches were decided on penalties in the Round of 16.
(SELECT COUNT(*)
FROM match_mast
WHERE play_stage = 'R' AND decided_by = 'P')

-- 11. Write a query in SQL to find the number of goal scored in every match within normal play schedule. 
SELECT match_no, COUNT(*)
FROM goal_details
WHERE goal_schedule = 'NT' 
GROUP BY match_no
ORDER BY match_no

-- 12. Write a query in SQL to find the match no, date of play, and goal scored for that match in which no stoppage time have been added in 1st half of play. 
SELECT match_no, play_date, goal_score 
FROM match_mast
WHERE stop1_sec = 0

-- 13. Write a query in SQL to find the number of matches ending with a goalless draw in group stage of play. 
SELECT COUNT(DISTINCT(match_no))
FROM match_details
WHERE goal_score = 0 AND play_stage = 'G' AND win_lose = 'D'

-- 14. Write a query in SQL to find the number of matches ending with only one goal win except those matches which was decided by penalty shootout.
SELECT *
FROM match_details 
WHERE goal_score = 1 AND decided_by <> 'P' AND win_lose = 'W'

-- 15. Write a query in SQL to find the total number of players replaced in the tournament.
SELECT COUNT(*)
FROM player_in_out
WHERE in_out = 'I'

-- 16. Write a query in SQL to find the total number of palyers replaced within normal time of play.
SELECT COUNT(*)
FROM player_in_out
WHERE in_out = 'I' AND play_schedule = 'NT'

-- 17. Write a query in SQL to find the number of players replaced in the stoppage time. 
SELECT COUNT(*)
FROM player_in_out
WHERE in_out = 'I' AND play_schedule = 'ET'

-- 18. Write a query in SQL to find the total number of players replaced in the first half of play. 
SELECT COUNT(*)
FROM player_in_out
WHERE play_schedule = 'NT' AND in_out = 'I' AND play_half = '1'

-- 19. Write a query in SQL to find the total number of goalless draws have there in the entire tournament.
SELECT COUNT(*)
FROM player_in_out
WHERE play_schedule = 'NT' AND in_out = 'I' AND play_half = '1'

-- 20. Write a query in SQL to fine the total number of players replaced in the extra time of play. 
SELECT COUNT(*)
FROM player_in_out
WHERE in_out = 'I' AND play_schedule = 'ET' 

-- 21. Write a query in SQL to compute a list to show the number of substitute happened in various stage of play for the entire tournament.
SELECT play_half, play_schedule, COUNT(*)
FROM player_in_out
WHERE in_out = 'I' 
GROUP BY play_half, play_schedule
ORDER BY play_half

-- 22. Write a query in SQL to find the number of shots taken in penalty shootout matches.
SELECT COUNT(*)
FROM penalty_shootout

-- 23. Write a query in SQL to find the number of shots socred goal in penalty shootout matches.
SELECT COUNT(*)
FROM penalty_shootout
WHERE score_goal = 'Y'

-- 24. Write a query in SQL to find the number of shots missed or saved in penalty shootout matches.
SELECT COUNT(*)
FROM penalty_shootout
WHERE score_goal = 'N'

SELECT team_id, score_goal, COUNT(*)
FROM penalty_shootout
GROUP BY team_id, score_goal

-- 25. Write a query in SQL to prepare a list of players with number of shots they taken in penalty shootout matches.
SELECT pm.player_name, sc.country_name, COUNT(*)
FROM penalty_shootout ps
INNER JOIN player_mast pm ON pm.player_id = ps.player_id
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id 
GROUP BY pm.player_name,  sc.country_name

-- 26. Write a query in SQL to find the number of penalty shots taken by the teams
SELECT sc.country_name, COUNT(*)
FROM penalty_shootout ps
INNER JOIN soccer_country sc ON sc.country_id = ps.team_id 
GROUP BY sc.country_name

-- 27. Write a query in SQL to find the number of booking happened in each half of play within normal play schedule. 
SELECT play_half, COUNT(*)
FROM player_booked 
WHERE play_schedule = 'NT'
GROUP BY play_half

-- 28. Write a query in SQL to find the number of booking happened in stoppage time.
SELECT COUNT(*)
FROM player_booked 
WHERE play_schedule = 'ST'

-- 29. Write a query in SQL to find the number of booking happened in extra time.
SELECT COUNT(*)
FROM player_booked 
WHERE play_schedule = 'ET'