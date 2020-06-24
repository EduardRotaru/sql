

-- Wildcard and Special operators
-- 1. Write a SQL statement to find those salesmen with all information who come from the city either Paris or Rome. 
SELECT *
FROM salesman
WHERE city LIKE '%Paris%' OR city LIKE '%Rome%'

SELECT *
FROM salesman
WHERE city = 'Paris' OR city = 'Rome'

-- 2. Write a query to filter those salesmen with all information who comes from any of the cities Paris and Rome.  
SELECT *
FROM salesman
WHERE city IN('Paris','Rome')

-- 3. Write a query to produce a list of salesman_id, name, city and commission of each salesman who live in cities other than Paris and Rome.
SELECT  salesman_id, name, city, commission
FROM salesman
WHERE city NOT IN('Paris','Rome')

-- 4. Write a query to sort out those customers with all information whose ID value is within any of 3007, 3008 and 3009.  
SELECT *
FROM customer
WHERE customer_id IN(3007, 3008, 3009)

-- 5. Write a SQL statement to find those salesmen with all information who gets the commission within a range of 0.12 and 0.14. 
SELECT *
FROM salesman
WHERE commission BETWEEN 0.12 AND 0.14

-- 6. Write a query to filter all those orders with all information which purchase amount value 
		-- is within the range 500 and 4000 except those orders of purchase amount value 948.50 and 1983.43.
SELECT *
FROM orders
WHERE purch_amt NOT IN(948.50, 1983.43) AND purch_amt BETWEEN 500 AND 4000

-- 7. Write a SQL statement to find those salesmen with all other information and name started with any letter within 'A' and 'K'.  
SELECT * 
FROM salesman
WHERE name BETWEEN 'A' AND 'K'
		-- in answer is 'L' instead of K. If within word is not inclusive then it should have started from B.

-- 8. Write a SQL statement to find those salesmen with all other information and name started with other than any latter within 'A' and 'L'.  
SELECT * 
FROM salesman
WHERE name NOT BETWEEN 'A' AND 'K'

-- 9. Write a SQL statement to find that customer with all information whose name begin with the letter 'B'. 
SELECT * 
FROM customer
WHERE cust_name LIKE 'B%'

-- 10. Write a SQL statement to find all those customers with all information whose names are ending with the letter 'n'.
SELECT * 
FROM customer
WHERE cust_name LIKE '%n'

-- 11. Write a SQL statement to find those salesmen with all information whose name containing the 1st character is 'N' and the 4th character is 'l' 
		-- and rests may be any character
SELECT * 
FROM salesman
WHERE name LIKE 'N__l%'

-- 12. Write a SQL statement to find those rows from the table testtable which contain the escape character underscore ( _ ) in its column 'col1'.
SELECT * 
FROM testtable
WHERE col1 LIKE '%/_%' ESCAPE('/')

-- 13. Write a SQL statement to find those rows from the table testtable which does not contain the character underscore ( _ ) in its column 'col1'.
SELECT * 
FROM testtable
WHERE col1 NOT LIKE '%/_%' ESCAPE('/')

-- 14. Write a SQL statement to find those rows from the table testtable which contain the escape character ( / ) in its column 'col1'. 
SELECT * 
FROM testtable
WHERE col1 LIKE '%//%' ESCAPE('/')

-- 15. Write a SQL statement to find those rows from the table testtable which does not contain the escape character ( / ) in its column 'col1'. 
SELECT * 
FROM testtable
WHERE col1 NOT LIKE '%//%' ESCAPE('/')

-- 16. Write a SQL statement to find those rows from the table testtable which contain the string ( _/ ) in its column 'col1'.
SELECT * 
FROM testtable
WHERE col1 LIKE '%/_//%' ESCAPE('/')

-- 17. Write a SQL statement to find those rows from the table testtable which does not contain the string ( _/ ) in its column 'col1'. 
SELECT *
FROM testtable
WHERE col1 NOT LIKE '%/_//%' ESCAPE ('/')

-- 18. Write a SQL statement to find those rows from the table testtable which contain the character ( % ) in its column 'col1'.
SELECT *
FROM testtable
WHERE col1 LIKE '%/%%' ESCAPE ('/')

-- 19. Write a SQL statement to find those rows from the table testtable which does not contain the character ( % ) in its column 'col1'.
SELECT *
FROM testtable
WHERE col1 NOT LIKE '%/%%' ESCAPE ('/')

-- 20. Write a SQL statement to find that customer with all information who does not get any grade except NULL. 
SELECT *
FROM customer
WHERE grade IS NULL

-- 21. Write a SQL statement to find that customer with all information who gets a grade except NULL value.  
SELECT *
FROM customer
WHERE grade IS NOT NULL

-- 22. Write a query in SQL to display all the data of employees whose last name begins with an 'D'
SELECT *
FROM emp_details
WHERE EMP_LNAME LIKE 'D%'

-- NOTES
-- ESCAPE AND COUNTING SPACES IN A STRING
-----------------------------------------------------  END OF FIFTH PROBLEMS --------------------------------------------------
