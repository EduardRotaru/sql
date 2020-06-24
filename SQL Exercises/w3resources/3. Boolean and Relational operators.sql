-- 1. Write a query to display all customers with a grade above 100.  Sample table: customer
-- SELECT * FROM customer
-- WHERE grade > 100

-- 2. Write a query statement to display all customers in New York who have a grade value above 100. 
-- SELECT * FROM customer
-- WHERE city = 'New York' AND grade > 100

-- 3. Write a SQL statement to display all customers, who are either belongs to the city New York or had a grade above 100. 
-- SELECT * FROM customer
-- WHERE city = 'New York' OR grade > 100

-- 4. Write a SQL statement to display all the customers, who are either belongs to the city New York or not had a grade above 100.
-- SELECT * FROM customer
-- WHERE city = 'New York' OR NOT grade > 100

-- 5. Write a SQL query to display those customers who are neither belongs to the city New York nor grade value is more than 100.
-- My version, all I understand that the customer doesn't belong to New York and grade value is not higher than 100
-- SELECT * FROM customer
-- WHERE city <> 'New York' AND NOT grade > 100

-- Website solution, which doesn't corespond with their "correct output" lol. All I understood from here is that I can use NOT after WHERE and negate a true boolean condition.
-- SELECT * FROM customer
-- WHERE NOT (city = 'New York' OR grade > 100)

-- 6. Write a SQL statement to display either those orders which are not issued on date 2012-09-10 and issued by the salesman whose ID is 505 and below or those orders which purchase amount is 1000.00 and below. Sample table : orders
-- SELECT * FROM orders
-- WHERE NOT(ord_date = '2012-09-10') AND (salesman_id < 505 OR purch_amt < 1000)

-- 7. Write a SQL statement to display salesman_id, name, city and commission who gets the commission within the range more than 0.10% and less than 0.12%.  Sample table : salesman
-- SELECT * FROM salesman
-- WHERE commission BETWEEN 0.10 AND 0.12 -- BETWEEN represents <= and >=

-- SELECT * FROM salesman
-- WHERE commission > 0.10 AND commission < 0.12

-- 8. Write a SQL query to display all orders where purchase amount less than 200 or exclude those orders which order date is on or greater than 10th Feb,2012 and customer id is below 3009.  Sample table : orders
-- SELECT * FROM orders
-- WHERE purch_amt < 200 OR NOT(ord_date >= '2012-02-10' AND customer_id < 3009)

-- 9. Write a SQL statement to exclude the rows which satisfy 
-- 1) order dates are 2012-08-17 and purchase amount is below 1000 
-- 2) customer id is greater than 3005 and purchase amount is below 1000.  Sample table : orders
-- SELECT * FROM orders
-- WHERE NOT((ord_date = '2012-08-17' OR customer_id > 3005) AND purch_amt < 1000) 

-- 10. Write a SQL query to display order number, purchase amount, achieved, the unachieved percentage for those order which exceeds the 50% of the target value of 6000. 
-- SELECT ord_no, purch_amt, (100*purch_amt)/6000 as achieved FROM orders
-- WHERE (100 * purch_amt) / 6000 > 50

-- 11. Write a query in SQL to find the data of employees whose last name is Dosni or Mardy. Sample table : emp_details
-- SELECT * FROM emp_details 
-- WHERE emp_lname = 'Dosni' OR emp_lname = 'Mardy'

-- 12. Write a query in SQL to display all the data of employees that work in department 47 or department 63.    
-- SELECT * FROM emp_details
-- WHERE emp_dept = 47 OR emp_dept = 63

-- SELECT * FROM emp_details
-- WHERE emp_dept IN(47,63)
-----------------------------------------------------  END OF FOURTH PROBLEMS --------------------------------------------------