1. https://www.hackerrank.com/challenges/what-type-of-triangle/problem

SELECT 
CASE
WHEN A + B > C AND A + C > B AND B + C > A
    THEN 
        CASE 
            WHEN A = B AND B = C THEN 'Equilateral'
            WHEN A <> B AND A <> C AND B <> C THEN 'Scalene'
            WHEN A = B OR B = C OR A = C THEN 'Isosceles'
        END
    ELSE 
        'Not A Triangle'
END
FROM TRIANGLES  

2. https://www.hackerrank.com/challenges/draw-the-triangle-2/problem

DECLARE @p INT

SELECT @p = 1
WHILE @p <= 20
BEGIN
PRINT REPLICATE('* ', @p)
SET @p = @p + 1;
END

3. https://www.hackerrank.com/challenges/draw-the-triangle-1/problem

DECLARE @p INT

SELECT @p = 20
WHILE @p >= 1
BEGIN
PRINT REPLICATE('* ', @p)
SET @p = @p - 1;
END

4. https://www.hackerrank.com/challenges/earnings-of-employees/problem

SELECT TOP 1 (SALARY * MONTHS) AS 'TopEarnings', COUNT(*)
FROM Employee
GROUP BY (SALARY * MONTHS)
ORDER BY TopEarnings DESC

5. https://www.hackerrank.com/challenges/symmetric-pairs/problem

SELECT f1.X, f1.Y
FROM Functions f1
INNER JOIN Functions f2 ON f1.X = f2.Y AND f2.X = f1.Y
GROUP BY f1.X, f1.Y
HAVING COUNT(f1.X) > 1 OR f1.X < f1.Y
ORDER BY f1.X

6. https://www.hackerrank.com/challenges/contest-leaderboard/problem

SELECT s.hacker_id, h.name, SUM(score)
FROM Hackers h
INNER JOIN (SELECT MAX(score) as score, hacker_id
           FROM Submissions
           GROUP BY hacker_id, challenge_id) s 
ON h.hacker_id = s.hacker_id 
GROUP BY s.hacker_id, h.name
HAVING SUM(score) > 0 
ORDER BY SUM(score) DESC, s.hacker_id

7. https://www.hackerrank.com/challenges/harry-potter-and-wands/problem

SELECT w.id, wp.age, w.coins_needed, w.power
FROM Wands w
INNER JOIN Wands_Property wp ON w.code = wp.code
WHERE wp.is_evil = 0 
    AND w.coins_needed =(SELECT MIN(coins_needed)
                        FROM Wands w1
                        INNER JOIN Wands_Property wp1 ON w1.code = wp1.code
                        WHERE w1.power = w.power AND wp.age = wp1.age)
ORDER BY w.power DESC, wp.age DESC

8. https://www.hackerrank.com/challenges/weather-observation-station-18/problem

SELECT CAST(
            ABS(MIN(LAT_N) - MAX(LONG_W)) 
          + ABS(MAX(LAT_N) - MIN(LONG_W)) as decimal(7,4))
FROM STATION

9. https://www.hackerrank.com/challenges/weather-observation-station-20/problem
-- https://sqlperformance.com/2012/08/t-sql-queries/median
SELECT DISTINCT
CAST(PERCENTILE_CONT(0.5) 
     WITHIN GROUP (ORDER BY LAT_N) 
     OVER () as decimal (10, 4))
FROM station