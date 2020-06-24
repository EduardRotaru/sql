-- CTRL + /
-- https://www.pgadmin.org/docs/pgadmin4/dev/keyboard_shortcuts.html

-- FIRST Chapter: https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
-- Here I am exploring a bit of the basics, the only thing important I got from here is how UNION works. 
-- Initially I played a bit with functions and how I return types in psql but I figured its getting repetitive and long for no reasaon, while the simple queries can be placed in a BEGIN END block.

-- Update 1
-- https://www.essentialsql.com/get-ready-to-learn-sql-6-how-to-group-and-summarize-your-results/
	-- The SQL GROUP BY Clause is used to output a row across specified column values.  
	-- It is typically used in conjunction with aggregate functions such as SUM or Count to summarize values.  
	-- In SQL groups are unique combinations of fields.  Rather than returning every row in a table, when values are grouped, only the unique combinations are returned.
	
-- 1.
-- select * from salesman

-- 2.
-- select 'This is SQL Exercise, Practice and Solution' as Initial

-- CREATE OR REPLACE FUNCTION initial() RETURNS varchar(60) LANGUAGE plpgsql AS $$
-- DECLARE 
-- 	 initial varchar(60);
-- BEGIN
-- 	initial  := 'This is SQL Exercise, Practice and Solution';
-- 	RETURN initial;
-- END $$;
-- SELECT initial();

-- 3.
-- DROP TABLE threeNumbers;
-- CREATE TABLE threeNumbers(
-- 	number1 int,
-- 	number2 int,
-- 	number3 int
-- );

-- INSERT INTO threeNumbers VALUES(1,2,3);
-- INSERT INTO threeNumbers VALUES(11,22,33);
-- INSERT INTO threeNumbers VALUES(111,222,333);

-- CREATE OR REPLACE FUNCTION threeNumbers2() RETURNS TABLE(nr1 int, nr2 int ,nr3 int) LANGUAGE plpgsql AS $$
-- BEGIN
-- 	RETURN QUERY SELECT * FROM threeNumbers;
-- END $$;

-- -- SELECT * FROM threeNumbers;
-- -- SELECT * FROM threeNumbers2();

-- 4.
-- CREATE OR REPLACE FUNCTION customSum(numberA int, numberB int) RETURNS integer LANGUAGE plpgsql AS $$
-- DECLARE
-- -- 	numberA int;
-- -- 	numberB int;
-- BEGIN 
-- -- 	numberA := 2;
-- -- 	numberB := 3;
-- 	RETURN numberA + numberB;
-- END $$;

-- SELECT customSum(2,3);

-- 5.
-- CREATE OR REPLACE FUNCTION customSum2(numberA int, numberB int, numberC int, numberD int) RETURNS integer LANGUAGE plpgsql AS $$
-- DECLARE
-- BEGIN 
-- 	RETURN numberD / numberA + numberB * numberC;
-- END $$;

-- SELECT customSum2(2,3,1,4);

-- 6.
-- CREATE OR REPLACE FUNCTION get_salesmans() RETURNS TABLE(salesman_id numeric(5,0), name varchar(60), city varchar(60), comission numeric(5,2)) LANGUAGE plpgsql AS $$
-- BEGIN
-- RETURN QUERY SELECT salesman.salesman_id, salesman.name, salesman.city, salesman.commission FROM salesman;
-- END $$;
-- SELECT * from get_salesmans();

-- 7.
-- CREATE OR REPLACE FUNCTION get_orders_with_custom_column_order() RETURNS TABLE(ord_date date, salesman_id numeric(5,0), ord_no numeric(5,0), purch_amt numeric(5,2)) LANGUAGE plpgsql AS $$
-- BEGIN
-- RETURN QUERY SELECT orders.ord_date, orders.salesman_id, orders.ord_no, orders.purch_amt FROM orders;
-- END $$;
-- SELECT * from get_orders_with_custom_column_order();

-- 8.
-- SELECT DISTINCT * FROM orders;

-- 9.
-- SELECT * FROM salesman
-- WHERE city = 'Paris'

-- 10.
-- SELECT * FROM customer
-- WHERE grade = 200

-- 11.
-- SELECT ord_no, ord_date, purch_amt FROM orders
-- WHERE salesman_id = 5001

-- 12.
-- SELECT * from nobel_win
-- WHERE nobel_win.year = 1970

-- 13.
-- SELECT DISTINCT winner from nobel_win
-- WHERE subject = 'Literature' AND nobel_win.year = 1971

-- 14.
-- SELECT DISTINCT "year", subject FROM nobel_win
-- WHERE winner = 'Dennis Gabor'

-- 15.
-- SELECT DISTINCT winner FROM nobel_win
-- WHERE nobel_win.year > 1950 AND subject = 'Physics'

-- 16.
-- SELECT DISTINCT * FROM nobel_win
-- WHERE subject = 'Chemistry' AND (nobel_win.year > 1965 AND nobel_win.year <= 1975)

-- 17. Write a SQL query to show all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin. 
-- SELECT DISTINCT * FROM nobel_win
-- WHERE category = 'Prime Minister' AND nobel_win.year > 1972 AND winner IN('Menachem Begin', 'Yitzhak Rabin')

-- 18. Write a SQL query to show all the details of the winners with first name Louis.
-- SELECT DISTINCT winner from nobel_win
-- WHERE winner LIKE 'Louis %'

-- 19. Write a SQL query to show all the winners in Physics for 1970 together with the winner of Economics for 1971. 
-- SELECT DISTINCT * FROM nobel_win
-- WHERE subject = 'Physics' AND "year" = 1970 OR subject = 'Economics' AND year = 1971

-- SELECT DISTINCT * FROM nobel_win
-- WHERE subject = 'Physics' AND year = 1970 UNION(SELECT * FROM nobel_win WHERE subject = 'Economics' AND year = 1971)

-- 20. Write a SQL query to show all the winners of nobel prize in the year 1970 except the subject Physiology and Economics. 
-- SELECT DISTINCT * FROM nobel_win
-- WHERE "year" = 1970 AND subject NOT IN('Physiology', 'Economics')

-- 21. Write a SQL query to show the winners of a 'Physiology' prize in an early year before 1971 together with winners of a 'Peace' prize in a later year on and after the 1974.
-- SELECT winner FROM nobel_win
-- WHERE subject = 'Physiology' AND nobel_win.year < 1971 UNION(SELECT winner FROM nobel_win WHERE subject = 'Peace' AND nobel_win.year > 1974)

-- 22. Write a SQL query to find all details of the prize won by Johannes Georg Bednorz.
-- SELECT DISTINCT * FROM nobel_win
-- WHERE winner = 'Johannes Georg Bednorz'

-- 23. Write a SQL query to find all the details of the nobel winners for the subject not started with the letter 'P' and arranged the list as the most recent comes first, then by name in order. 
-- SELECT DISTINCT * FROM nobel_win
-- WHERE subject NOT LIKE 'P%' 
-- ORDER BY nobel_win.year, nobel_win.winner

-- 24. Write a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last.
-- SELECT DISTINCT * FROM nobel_win
-- WHERE nobel_win.year = 1970 ORDER BY subject DESC

-- 25. Write a SQL query to find all the products with a price between Rs.200 and Rs.600. 
-- SELECT * FROM item_mast
-- WHERE pro_price >= 200 AND pro_price <= 600

-- SELECT * FROM item_mast
-- WHERE pro_price BETWEEN 200 AND 600

-- 26. Write a SQL query to calculate the average price of all products of the manufacturer which code is 16. 
-- SELECT AVG(pro_price) as average from item_mast
-- WHERE pro_com = 16

-- 27. Write a SQL query to find the item name and price in Rs.   
-- dumb text, I didn't understood what Rs means, turns out its about using aliases

-- SELECT pro_name, pro_price FROM item_mast
-- SELECT pro_name as "Rs name", pro_price as "Rs price" FROM item_mast

-- 28. Write a SQL query to display the name and price of all the items with a price is equal or more than Rs.250, and the list contain the larger price first and then by name in ascending order. 
-- SELECT * FROM item_mast
-- WHERE pro_price >= 250 ORDER BY pro_price DESC, pro_name

-- 29. Write a SQL query to display the average price of the items for each company, showing only the company code. 
-- SELECT  AVG(pro_price) as avg_price, pro_com FROM item_mast
-- GROUP BY pro_com

-- 30. Write a SQL query to find the name and price of the cheapest item(s). 
-- SELECT AVG(pro_price) as cheapest_prices, pro_name FROM item_mast
-- GROUP BY pro_name
-- ORDER BY cheapest_prices ASC

-- 31. Write a query in SQL to find the last name of all employees, without duplicates. 
-- SELECT DISTINCT emp_lname FROM emp_details

-- 32. Write a query in SQL to find the data of employees whose last name is 'Snares'.  
-- SELECT DISTINCT * FROM emp_details
-- WHERE emp_lname = 'Snares'

-- 33. Write a query in SQL to display all the data of employees that work in the department 57.
-- SELECT DISTINCT * FROM emp_details
-- WHERE emp_dept = 57

-- SUMMARY
-- Basics covered on first chapter:
-- SELECT, WHERE, BETWEEN, IN, UNION, ORDER BY, CASE, DISTINCT
-- GROUP BY, MIN AVG

-- UNCOVERED
-- ROUNDING, CASTING, 

-----------------------------------------------------  END OF FIRST PROBLEMS --------------------------------------------------
