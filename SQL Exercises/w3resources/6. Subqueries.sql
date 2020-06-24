

-- SUBQUERIES
-- 1. Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'.
SELECT *
FROM orders
WHERE salesman_id = (SELECT salesman_id
					FROM salesman
					WHERE name = 'Paul Adam')

-- 2. Write a query to display all the orders for the salesman who belongs to the city London.
SELECT *
FROM orders
WHERE salesman_id = (SELECT salesman_id
					FROM salesman
					WHERE city = 'London')
					
-- 3. Write a query to find all the orders issued against the salesman who may works for customer whose id is 3007. 
SELECT *
FROM orders
WHERE salesman_id = (SELECT DISTINCT salesman_id
					FROM orders
					WHERE customer_id = 3007)
					
-- 4. Write a query to display all the orders which values are greater than the average order value for 10th October 2012.
SELECT *
FROM orders
WHERE purch_amt > (SELECT AVG(purch_amt)
					FROM orders
					WHERE ord_date = '2012-10-10')

-- 5. Write a query to find all orders attributed to a salesman in New york. 
SELECT *
FROM orders
WHERE salesman_id IN (SELECT salesman_id
					FROM salesman
					WHERE city = 'New York')

-- 6. Write a query to display the commission of all the salesmen servicing customers in Paris. 
SELECT commission
FROM salesman
WHERE salesman_id IN (SELECT salesman_id
					FROM customer
					WHERE city = 'Paris')

-- 7. Write a query to display all the customers whose id is 2001 bellow the salesman ID of Mc Lyon. 
SELECT *
FROM customer
WHERE customer_id = (SELECT salesman_id-2001
					FROM salesman
					WHERE name LIKE '%Mc Lyon%')

-- 8. Write a query to count the customers with grades above New York's average. 
SELECT COUNT(*)
FROM customer
WHERE grade > (SELECT AVG(grade)
					FROM customer
					WHERE city = 'New York')
-- 8. Questions are dumb worded.
SELECT grade, COUNT(*)
FROM customer
GROUP BY grade
HAVING grade > (SELECT AVG(grade)
					FROM customer
					WHERE city = 'New York')

-- 9. Write a query to display all customers with orders on October 5, 2012. '
SELECT * 
FROM customer
WHERE customer_id IN (SELECT customer_id
					FROM orders
					WHERE ord_date = '2012-10-05')

-- 10. Write a query to display all the customers with orders issued on date 17th August, 2012.  
SELECT * 
FROM customer
WHERE customer_id IN (SELECT customer_id
					FROM orders
					WHERE ord_date = '2012-08-17')

-- 11. Write a query to find the name and numbers of all salesmen who had more than one customer.
SELECT salesman_id, commission, name
FROM salesman
WHERE salesman_id IN(SELECT salesman_id
					 FROM customer
					 GROUP BY salesman_id
					 HAVING COUNT(customer_id) > 1) 

-- 12. Write a query to find all orders with order amounts which are above-average amounts for their customers. 
SELECT * 
FROM orders o
WHERE purch_amt > (SELECT AVG(purch_amt)
					FROM orders c
					WHERE o.customer_id = c.customer_id)

-- 13. Write a queries to find all orders with order amounts which are on or above-average amounts for their customers. 
SELECT * 
FROM orders o
WHERE purch_amt >= (SELECT AVG(purch_amt)
					FROM orders c
					WHERE o.customer_id = c.customer_id)

-- 14. Write a query to find the sums of the amounts from the orders table, grouped by date, 
		-- eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.
SELECT SUM(purch_amt), ord_date
FROM orders a
GROUP BY ord_date
HAVING SUM(purch_amt) > (SELECT MAX(purch_amt) + 1000.00
						 FROM orders b
						 WHERE a.ord_date = b.ord_date)

-- 15. Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London. 
SELECT *
FROM customer
WHERE 1 <= (SELECT COUNT(*)
		   FROM customer
		   WHERE city = 'London')
		   
SELECT *
FROM customer
WHERE EXISTS (SELECT *
		   FROM customer
		   WHERE city = 'London')

-- 16. Write a query to find the salesmen who have multiple customers
SELECT *
FROM Salesman
WHERE salesman_id IN (SELECT salesman_id  
					FROM Customer
					GROUP BY salesman_id
					HAVING COUNT(customer_id) > 1)

-- 17. Write a query to find all the salesmen who worked for only one customer. 
SELECT *
FROM Salesman
WHERE salesman_id IN(SELECT salesman_id  
					FROM Customer
					GROUP BY salesman_id
					HAVING COUNT(customer_id) = 1)

-- 18. Write a query that extract the rows of all salesmen who have customers with more than one orders.
SELECT *
FROM Salesman
WHERE 1 < (SELECT COUNT(customer_id)
		  FROM Orders
		  WHERE Salesman.salesman_id = Orders.salesman_id)
		  
SELECT *
FROM Salesman
WHERE salesman_id IN(SELECT salesman_id
					FROM Orders
					GROUP BY salesman_id, customer_id  
					HAVING COUNT(ord_no) > 1)

-- 19. Write a query to find salesmen with all information who lives in the city where any of the customers lives.
SELECT *
FROM Salesman
WHERE city IN(SELECT city
			FROM customer)
			
SELECT *
FROM Salesman
WHERE city = ANY(SELECT city
				FROM customer)

-- 20. Write a query to find all the salesmen for whom there are customers that follow them
-- I don't understand this text, I am assuming to select the customers that buy from a specific salesman
SELECT *
FROM Salesman
WHERE salesman_id IN(SELECT salesman_id
			  		FROM customer)

-- 21. Write a query to display the salesmen which name are alphabetically lower than the name of the customers.
SELECT *
FROM Salesman s
INNER JOIN Customer c ON s.salesman_id = c.salesman_id  
WHERE s.name < c.cust_name

SELECT *
FROM Salesman
WHERE name < ANY(SELECT cust_name
				FROM Customer)

-- 22. Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York. 
SELECT *
FROM Customer c 
WHERE c.city < ANY(SELECT city
				FROM Customer
				WHERE city < 'New York')
				
-- 23. Write a query to display all the orders that had amounts that were greater than at least one of the orders on September 10th 2012
SELECT *
FROM Orders
WHERE purch_amt > ANY(SELECT purch_amt
					 FROM Orders
					 WHERE ord_date = '2012.09.10'::date)

-- 24. Write a query to find all orders with an amount smaller than any amount for a customer in London.
SELECT *
FROM Orders
WHERE purch_amt < ANY(SELECT purch_amt
					 FROM Customer c
					 INNER JOIN Orders o ON o.customer_id = c.customer_id
					 WHERE c.city = 'London')

-- 25. Display all orders with an amount smaller than max amount for a customer in London
SELECT *
FROM Orders
WHERE purch_amt < ANY(SELECT MAX(purch_amt)
					 FROM Customer c
					 INNER JOIN Orders o ON o.customer_id = c.customer_id
					 WHERE city = 'London')

-- 26. Write a query to display only those customers whose grade are, in fact, higher than every customer in New York. 
SELECT *
FROM Customer
WHERE grade > ALL(SELECT grade -- it ask for EVERY customer, so I need to use ALL not ANY because condition needs to be true for all customers.
				 FROM Customer
				 WHERE city = 'New York')

-- 27. Write a query in sql to find the name, city, and the total sum of orders amount a salesman collects. 
	-- Salesman should belong to the cities where any of the customer belongs.
SELECT Salesman.name, Salesman.city, subquery_sum.total_amt
FROM Salesman, (SELECT salesman_id, SUM(Orders.purch_amt) AS total_amt
			   FROM Orders
			   GROUP BY salesman_id) subquery_sum
			   WHERE subquery_sum.salesman_id = Salesman.salesman_id
			   		AND Salesman.city IN(SELECT DISTINCT city FROM customer)

-- 28. Write a query to get all the information for those customers whose grade is not as the grade of customer who belongs to the city London.
SELECT *
FROM Customer
WHERE grade <> ANY(SELECT grade
				  FROM Customer
				  WHERE city = 'London')

-- 29. Write a query to find all those customers whose grade are not as the grade, belongs to the city Paris.
SELECT *
FROM Customer
WHERE grade <> ANY(SELECT grade
				  FROM Customer
				  WHERE city = 'Paris')
				  
SELECT *
FROM Customer
WHERE grade NOT IN(SELECT grade
				  FROM Customer
				  WHERE city = 'Paris')

-- 30. Write a query to find all those customers who hold a different grade than any customer of the city Dallas
SELECT *
FROM Customer
WHERE grade NOT IN(SELECT grade
				  FROM Customer
				  WHERE city = 'Dallas')
				  
SELECT *
FROM Customer
WHERE NOT grade = ANY(SELECT grade
				  FROM Customer
				  WHERE city = 'Dallas')

-- 31. Write a SQL query to find the average price of each manufacturer's products along with their name.
SELECT AVG(PRO_PRICE), manufacter_info.COM_NAME
FROM item_mast, (SELECT *
				FROM company_mast) manufacter_info
WHERE item_mast.PRO_COM = manufacter_info.COM_ID
GROUP BY manufacter_info.COM_NAME

-- 32. Write a SQL query to display the average price of the products which is more than or equal to 350 along with their names.
SELECT AVG(PRO_PRICE), manufacter_info.COM_NAME
FROM item_mast, (SELECT *
				FROM company_mast) manufacter_info
WHERE item_mast.PRO_COM = manufacter_info.COM_ID
GROUP BY manufacter_info.COM_NAME
HAVING AVG(PRO_PRICE) >= 350

-- 33. Write a SQL query to display the name of each company, price for their most expensive product along with their Name.

-- 34. Write a query in SQL to find all the details of employees whose last name is Gabriel or Dosio.
SELECT * 
FROM emp_details
WHERE EMP_LNAME = 'Gabriel' OR EMP_LNAME = 'Dosio'

-- 35. Write a query in SQL to display all the details of employees who works in department 89 or 63.
SELECT * 
FROM emp_details
WHERE EMP_DEPT IN(SELECT DPT_CODE 
				 FROM emp_department
				 WHERE DPT_CODE IN(89,63))

-- 36. Write a query in SQL to display the first name and last name of employees working for the department which allotment amount is more than Rs.50000.
SELECT * 
FROM emp_details
WHERE EMP_DEPT IN(SELECT DPT_CODE 
				 FROM emp_department
				 WHERE DPT_ALLOTMENT > 50000)

-- 37. Write a query in SQL to find the departments which sanction amount is larger than the average sanction amount of all the departments.
SELECT * 
FROM emp_department
WHERE DPT_ALLOTMENT > (SELECT AVG(DPT_ALLOTMENT)
					  FROM emp_department)

-- 38. Write a query in SQL to find the names of departments with more than two employees are working.
SELECT * 
FROM emp_department
WHERE DPT_CODE IN (SELECT EMP_DEPT
				  FROM emp_details
				  GROUP BY EMP_DEPT
				  HAVING COUNT(EMP_IDNO) > 2)

-- 39. Write a query in SQL to find the first name and last name of employees working for departments which sanction amount is second lowest.
SELECT * 
FROM emp_details
WHERE EMP_DEPT IN(SELECT DPT_CODE  
				 FROM emp_department
				 WHERE DPT_ALLOTMENT = (SELECT MIN(DPT_ALLOTMENT)
										 FROM emp_department
										 WHERE DPT_ALLOTMENT <> (SELECT MIN(DPT_ALLOTMENT)
																FROM emp_department)))

-- EXISTS KEYWORD