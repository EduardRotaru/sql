-----------------------------------------------------  VIEW ------------------------------------------------------------

-- 1. Write a query to create a view for those salesmen belongs to the city New York. 
CREATE VIEW SalesmanFromNewYork AS
SELECT *
FROM salesman
WHERE city = 'New York'

-- 2. Write a query to create a view for all salesmen with columns salesman_id, name, and city. 
CREATE VIEW AllSalesman AS
SELECT *
FROM salesman

-- 3. Write a query to find the salesmen of the city New York who achieved the commission more than 13%. 
SELECT *
FROM SalesmanFromNewYork
WHERE commission > 0.13

-- 4. Write a query to create a view to getting a count of how many customers we have at each level of a grade.  
CREATE VIEW AllCustomers AS
SELECT *
FROM customer

SELECT grade, COUNT(*)
FROM AllCustomers
GROUP BY grade

-- 5. Write a query to create a view 
	-- to keeping track the number of customers ordering, number of salesmen attached, average amount of orders and the total amount of orders in a day. 
CREATE VIEW CustomerEvidence AS
SELECT COUNT(*), AVG(purch_amt), ord_date
FROM orders
GROUP BY ord_date

SELECT *
FROM CustomerEvidence

-- 6. Write a query to create a view that shows for each order the salesman and customer by name. 
CREATE VIEW OrdersAndCustomer AS
SELECT o.ord_no, c.cust_name, s.name, o.purch_amt
FROM orders o, customer c, salesman s
WHERE o.salesman_id = s.salesman_id 
	AND o.customer_id = c.customer_id 
	
SELECT *
FROM OrdersAndCustomer

-- 7. Write a query to create a view that finds the salesman who has the customer with the highest order of a day. 
CREATE VIEW CustomerHighestOrderPerDay AS
SELECT s.name, o.purch_amt
FROM salesman s
INNER JOIN orders o ON s.salesman_id = o.salesman_id  
WHERE o.purch_amt = (SELECT MAX(purch_amt)
					FROM orders o2
					WHERE o.ord_date = o2.ord_date)
					
SELECT * 
FROM CustomerHighestOrderPerDay

-- 8. Write a query to create a view that finds the salesman who has the customer with the highest order at least 3 times on a day. 					
CREATE VIEW CustomerHighestOrderPerDayThreeTimesADay AS
SELECT s.name, o.purch_amt
FROM elitsalesman s
INNER JOIN orders o ON s.salesman_id = o.salesman_id  
WHERE o.purch_amt = (SELECT MAX(purch_amt)
					FROM orders o2
					WHERE o.ord_date = o2.ord_date)
GROUP BY s.name, o.purch_amt
HAVING COUNT(s.name) > 2
					
SELECT * 
FROM CustomerHighestOrderPerDayThreeTimesADay

-- 9. Write a query to create a view that shows all of the customers who have the highest grade.
CREATE VIEW CustomersWithHighestGrade AS
SELECT cust_name, grade 
FROM customer
WHERE grade = (SELECT MAX(grade)
			  FROM customer)
			  
SELECT *
FROM CustomersWithHighestGrade

-- 10. Write a query to create a view that shows the number of the salesman in each city.
CREATE VIEW SalesmanInEachCity AS
SELECT COUNT(salesman_id), city
FROM salesman
GROUP BY city

SELECT *
FROM SalesmanInEachCity

-- 11. Write a query to create a view that shows the average and total orders for each salesman after his or her name. (Assume all names are unique)
DROP VIEW IF EXISTS AverageAndTotalOrdersForEachSalesman
CREATE VIEW AverageAndTotalOrdersForEachSalesman AS
SELECT AVG(o.purch_amt), SUM(o.purch_amt), s.name    
FROM salesman s, orders o
WHERE s.salesman_id = o.salesman_id  
GROUP BY s.name

SELECT *
FROM AverageAndTotalOrdersForEachSalesman

-- 12. Write a query to create a view that shows each salesman with more than one customers.
DROP VIEW IF EXISTS SalesmanWithMoreThanOneCustomer

CREATE VIEW SalesmanWithMoreThanOneCustomer AS
SELECT *
FROM salesman s
WHERE (SELECT COUNT(*)
	  FROM customer c
	  WHERE s.salesman_id = c.salesman_id) > 1
	  
CREATE VIEW SalesmanWithMoreThanOneCustomer AS
SELECT COUNT(*), s.salesman_id, s.name
FROM salesman s
INNER JOIN customer c ON  s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(*) > 1

SELECT name
FROM SalesmanWithMoreThanOneCustomer

-- 13. Write a query to create a view 
	-- that shows all matches of customers with salesman 
		-- such that at least one customer in the city of customer served by a salesman in the city of the salesman.
DROP VIEW IF EXISTS SalesmanWithMoreThanOneCustomerInTheSameCity		
		
CREATE VIEW SalesmanWithMoreThanOneCustomerInTheSameCity AS
SELECT DISTINCT s.salesman_id, s.name, s.city
FROM salesman s
LEFT JOIN customer c ON s.city = c.city

SELECT *
FROM SalesmanWithMoreThanOneCustomerInTheSameCity

-- 14. Write a query to create a view that shows the number of orders in each day.
CREATE VIEW CountOrdersEachDay AS
SELECT COUNT(*), ord_date    
FROM orders
GROUP BY ord_date

SELECT *
FROM CountOrdersEachDay

-- 15. Write a query to create a view that finds the salesmen who issued orders on October 10th, 2012.
CREATE PROCEDURE SalesmanByDate(orderDate date)
LANGUAGE SQL
AS $$
SELECT *    
FROM orders
WHERE orderDate = orders.ord_date  
$$;

CALL SalesmanByDate('2012.10.10'::date);

DROP FUNCTION IF EXISTS SalesmanByDate(date);
DROP PROCEDURE IF EXISTS SalesmanByDate(date);

CREATE FUNCTION SalesmanByDate(orderDate date) 
RETURNS TABLE(ord_no numeric, purch_amt numeric, ord_date date, customer_id numeric, salesman_id numeric)
AS $$ 
SELECT *    
FROM orders
WHERE orderDate = orders.ord_date 
$$
LANGUAGE SQL;

SELECT * FROM SalesmanByDate('2012.10.10'::date);

-- 16. Write a query to create a view that finds the salesmen who issued orders on either August 17th, 2012 or October 10th, 2012.
DROP FUNCTION IF EXISTS SalesmanByDates(date,date);
CREATE FUNCTION SalesmanByDates(orderDate date, orderDate2 date) 
RETURNS TABLE(salesman_id numeric, name text, city text, commission numeric)
AS $$  
SELECT s.salesman_id, s.name, s.city, s.commission
FROM orders
INNER JOIN salesman s ON s.salesman_id = orders.salesman_id
WHERE orderDate = orders.ord_date OR orderDate2 = orders.ord_date
$$
LANGUAGE SQL;

SELECT * FROM SalesmanByDates('2012.10.10'::date, '2012.08.17'::date);


-- Find the differences between stored procedure, function view