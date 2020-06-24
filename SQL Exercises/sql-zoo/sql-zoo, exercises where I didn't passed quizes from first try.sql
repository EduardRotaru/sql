-- sql zoo

-- https://sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950
 
SELECT winner
FROM nobel
WHERE yr = 1962 AND subject = 'Literature'
   
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

SELECT winner
FROM nobel
WHERE yr >= 2000 AND subject = 'Peace'
 
SELECT yr, subject, winner
FROM nobel
WHERE yr BETWEEN 1980 AND 1989 AND subject = 'Literature'
 
SELECT * FROM nobel
WHERE winner  IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter', 'Barack Obama')
				  
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

SELECT winner, subject
FROM nobel
WHERE yr=1984
order by (
     case subject  
     when 'Chemistry' then 0 
     when 'Physics' then 1
     end
)

SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner 	

SELECT yr, subject, winner
FROM nobel
WHERE winner = 'EUGENE O''NEILL' 
 
SELECT yr, subject, winner
FROM nobel
WHERE winner = 'PETER GRÜNBERG' 
 
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910) 
         OR (subject = 'Literature' AND yr >= 2004)
		 
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980 AND subject NOT IN ('Chemistry', 'Medicine')
 
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Physics ' AND yr = 1980 ) 
         OR (subject = 'Chemistry' AND yr = 1984)
		 
SELECT winner, subject
FROM nobel
WHERE yr=1984
order by (
     case subject  
     when 'Chemistry' then 0
     when 'Physics' then 1
end
), subject, winner

-- https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial
-- 1.List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
	
-- 2.Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name 
FROM world
WHERE gdp/population > ALL (SELECT gdp/population
                            FROM world
                            WHERE name = 'United Kingdom') 
      AND continent ='Europe'
-- 3.List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent
FROM world
WHERE continent = ANY(SELECT continent  
                      FROM world
                      WHERE name IN ('Argentina', 'Australia'))   
ORDER BY name

-- 4.Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population
FROM world 
WHERE population BETWEEN (SELECT population
						FROM WORLD 
                        WHERE name = 'Canada')
				AND (SELECT population
					FROM world
					WHERE name = 'Poland')
                    
SELECT name, population
FROM world
WHERE population > (SELECT population
                    FROM world
                    WHERE name = 'Canada') 
AND population < (SELECT population
                    FROM world
                    WHERE name = 'Poland') 
                    
-- 5.Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name, CONCAT(CAST(ROUND(100*population/(SELECT population
                                    FROM world
                                    WHERE name = 'Germany'), 0) as float), '%') as percentage
FROM world
WHERE continent = 'Europe'

-- 6.Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name
FROM world
WHERE gdp > ALL(SELECT MAX(gdp)
              FROM world
              WHERE continent = 'Europe')
GROUP BY name

-- 7.Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

-- 8.List each continent and the name of the country that comes first alphabetically.
SELECT continent, name
FROM world x
WHERE name <= ALL(SELECT DISTINCT y.name
                      FROM world y
                      WHERE x.continent = y.continent)
ORDER BY name

-- 9.Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT x.name, x.continent, x.population
FROM world x
WHERE 25000000 >= ALL(SELECT population 
                      FROM world y
                      WHERE y.continent= x.continent
                      AND population > 0)
                      
-- 10.Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent
FROM world x
WHERE population / 3 >= ALL(SELECT population
                          FROM world y
                          WHERE x.continent = y.continent AND x.name != y.name)	
                          
-- https://sqlzoo.net/wiki/The_JOIN_operation

-- 1. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
