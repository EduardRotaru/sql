-- Query on Multiple Tables

-- 1
SELECT * 
FROM salesman AS s, customer AS c
WHERE s.city = c.city

-- 2
SELECT c.cust_name, s
FROM customer AS c, salesman AS s
WHERE c.salesman_id = s.salesman_id

-- 3
SELECT c.cust_name, o
FROM customer AS c, salesman AS s, orders AS o
WHERE c.city <> s.city
	AND o.salesman_id = c.salesman_id
	AND o.salesman_id = s.salesman_id

-- 4
SELECT o.ord_no, c.cust_name
FROM customer AS c, orders AS o
WHERE o.customer_id = c.customer_id

-- 5
SELECT DISTINCT c.cust_name, c.grade
FROM salesman AS s, customer AS c, orders AS o
WHERE c.grade IS NOT NULL 
	AND c.salesman_id IS NOT NULL
	AND s.city IS NOT NULL
	AND c.customer_id = o.customer_id

-- 5 Website version
SELECT c.cust_name, c.grade
FROM salesman AS s, customer AS c, orders AS o
WHERE c.grade IS NOT NULL 
	AND s.city IS NOT NULL
	AND c.customer_id = o.customer_id
	AND s.salesman_id = o.salesman_id
	
-- 6
SELECT c.cust_name, c.city, s.name, s.commission	
FROM salesman AS s, customer AS c
WHERE s.commission BETWEEN 0.12 AND 0.14
	AND s.salesman_id = c.salesman_id

-- 7
SELECT o.ord_no, c.cust_name, s.commission, s.commission*o.purch_amt AS "earned comission" 
FROM salesman AS s, customer AS c, orders AS o
WHERE c.grade >= 200
	AND c.salesman_id = s.salesman_id
	AND o.customer_id = c.customer_id
GROUP BY o.ord_no, c.cust_name, s.commission 

-----------------------------------------------------  END OF SECOND PROBLEMS --------------------------------------------------

-- Formatting Output
-- 1. Write a SQL statement to display the commission with the percent sign ( % ) with salesman ID, name and city columns for all the salesmen.
SELECT commission, '%', salesman_id, name, city
FROM salesman

-- 2. Write a SQL statement to find out the number of orders booked for each day and display it in such a format like "For 2001-10-10 there are 15 orders".
SELECT 'For', ord_date, 'there are', COUNT(*), 'orders'
FROM orders
GROUP BY ord_date

-- 3. Write a query to display the orders according to the order number arranged by ascending order. 
SELECT ord_no
FROM orders
ORDER BY ord_no ASC

-- 4. Write a SQL statement to arrange the orders according to the order date in such a manner that the latest date will come first then previous dates. 
SELECT ord_no
FROM orders
ORDER BY ord_no DESC

-- 5. Write a SQL statement to display the orders with all information in such a manner that, the older order date will come first and the highest purchase amount of same day will come first.  
SELECT ord_date, purch_amt
FROM orders
ORDER BY ord_date, purch_amt DESC

-- 6. Write a SQL statement to display the customer name, city, and grade, etc. and the display will be arranged according to the smallest customer ID. 
SELECT *
FROM customer
ORDER BY customer_id

-- 7. Write a SQL statement to make a report with salesman ID, order date and highest purchase amount in such an arrangement that, 
		-- the smallest salesman ID will come first along with their smallest order date.
SELECT salesman_id, ord_date, MAX(purch_amt)
FROM orders
GROUP BY salesman_id, ord_date
ORDER BY salesman_id, ord_date

-- 8. Write a SQL statement to display customer name, city and grade in such a manner that, the customer holding highest grade will come first.
SELECT cust_name, city, MAX(grade) AS MaxGrade
FROM customer
WHERE grade IS NOT NULL
GROUP BY cust_name, city
ORDER BY MaxGrade DESC

-- website version
SELECT cust_name, city, grade
FROM customer
ORDER BY 3 DESC

-- another version
SELECT cust_name, city, grade
FROM customer
WHERE grade IS NOT NULL
ORDER BY grade DESC

-- 9. Write a SQL statement to make a report with customer ID in such a manner that, the largest number of orders booked by the customer will come first along 
		-- with their highest purchase amount.
SELECT COUNT(DISTINCT ord_no) OrdersCount, salesman_id, MAX(purch_amt)
FROM orders
GROUP BY salesman_id
ORDER BY 1 DESC

-- 10. Write a SQL statement to make a report with order date in such a manner that, 
		-- the latest order date will come last along with the total purchase amount and total commission (15% for all salesmen) for that date. 
		
SELECT ord_date, SUM(purch_amt), SUM(purch_amt)*.15 AS "Salesman Comission"
FROM orders
GROUP BY ord_date
ORDER BY 1 

-----------------------------------------------------  END OF THIRD PROBLEMS --------------------------------------------------
