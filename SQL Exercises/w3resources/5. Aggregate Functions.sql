
-- Aggregate Functions

-- 1
SELECT SUM(purch_amt)
FROM orders

-- 2
SELECT AVG(purch_amt)
FROM orders

-- 3
SELECT COUNT(salesman_id)
FROM orders

SELECT COUNT(DISTINCT salesman_id)
FROM orders

-- 4
SELECT COUNT(cust_name)
FROM customer

-- 5
SELECT COUNT(grade)
FROM customer
WHERE grade IS NOT NULL

-- 5 website version
SELECT COUNT(ALL grade)
FROM customer

-- 6
SELECT MAX(purch_amt)
FROM orders

-- 7
SELECT MIN(purch_amt)
FROM orders

-- 8
SELECT city, MAX(grade)
FROM customer
GROUP BY city

-- 9
SELECT customer_id, MAX(purch_amt) AS Highest_Purchase_Amount
FROM orders
GROUP BY customer_id
ORDER BY customer_id, Highest_Purchase_Amount

-- 10
SELECT customer_id, ord_date, MAX(purch_amt)
FROM orders
GROUP BY customer_id, ord_date
ORDER BY customer_id

-- 11
SELECT salesman_id, MAX(purch_amt)
FROM orders
WHERE ord_date = '2012-08-17'
GROUP BY salesman_id

-- 12
SELECT ord_no, ord_date, MAX(purch_amt)
FROM orders
GROUP BY ord_no, ord_date
HAVING  MAX(purch_amt) > 2000

-- 13
SELECT ord_no, ord_date, MAX(purch_amt)
FROM orders
GROUP BY ord_no, ord_date
HAVING MAX(purch_amt) BETWEEN 2000 AND 6000

-- 14
SELECT ord_no, ord_date, MAX(purch_amt)
FROM orders
GROUP BY ord_no, ord_date
HAVING MAX(purch_amt) IN(2000, 3000, 5760, 6000)

-- 15
SELECT customer_id, MAX(purch_amt)
FROM orders
WHERE customer_id BETWEEN 3002 AND 3007
GROUP BY customer_id

-- 16
SELECT customer_id, ord_no, purch_amt, MAX(purch_amt) AS "Purchases > 2000"
FROM orders
WHERE customer_id BETWEEN 3002 AND 3007
GROUP BY customer_id, ord_no, purch_amt
HAVING MAX(purch_amt) > 1000 
ORDER BY customer_id

-- 17
SELECT salesman_id, MAX(purch_amt)
FROM orders
WHERE salesman_id BETWEEN 5003 AND 5008
GROUP BY salesman_id

-- 18
SELECT COUNT(*)
FROM orders
WHERE ord_date = '2012-08-17'

-- 19
SELECT COUNT(*)
FROM salesman
WHERE TRIM(city) IS NOT NULL

-- 20
SELECT ord_date, salesman_id, COUNT(*)
FROM orders
GROUP BY ord_date, salesman_id

-- 21
SELECT AVG(pro_price)
FROM item_mast

-- 22
SELECT COUNT(*)
FROM item_mast
WHERE pro_price >= 350

-- 23
SELECT AVG(pro_price), pro_com
FROM item_mast
GROUP BY pro_com

-- 24
SELECT SUM(DPT_ALLOTMENT)
FROM emp_department

-- 25
-- Write a query in SQL to find the number of employees in each department along with the department code. 
SELECT AVG(pro_price), pro_com
FROM item_mast
GROUP BY pro_com

-- NOTES
-- ALL, ANY, SOME.
-- GROUP BY, AGGREGATE AND HAVING

-- HAVING APPLIES A CONDITION ON AGGREGATION
-- WHERE APPLIES A CONDITION ON ROWS, WE CANT USE ANY AGGREGATES ON WHERE CONDITION.
-----------------------------------------------------  END OF SIXTH PROBLEMS --------------------------------------------------