-----------------------------------------------------  UNION -----------------------------------------------------------
-- 1. Write a query to display all salesmen and customer located in London.
SELECT salesman_id "Salesman", name
FROM Salesman
WHERE city = 'London'
UNION ALL
	(SELECT customer_id "Customer", cust_name    
	FROM Customer
	WHERE city = 'London')

-- 2. Write a query to display distinct salesman and their cities
SELECT salesman_id "Salesman", city    
FROM Salesman
UNION
	(SELECT customer_id "Customer", city        
	FROM Customer)

-- 3. Write a query to display all the salesmen and customer involved in this inventory management system.
SELECT salesman_id "Salesman", customer_id             
FROM customer
UNION
	(SELECT salesman_id "Customer", customer_id          
	FROM orders)

-- 4. Write a query to make a report of which salesman produce the largest and smallest orders on each date.

-- 5. Write a query to make a report of which salesman produce the largest and smallest orders on each date and arranged the orders number in smallest to the largest number.

-- 6. Write a query to list all the salesmen, and indicate those who do not have customers in their cities, as well as whose who do.

-- 7. Write a query to that appends strings to the selected fields, indicating whether or not a specified salesman was matched to a customer in his city. 

-- 8. Create a union of two queries that shows the names, cities, and ratings of all customers. Those with a rating of 200 or greater will also have the words "High Rating", while the others will have the words "Low Rating".

-- 9. Write a command that produces the name and number of each salesman and each customer with more than one current order. Put the results in alphabetical order.

-- For exactly same rows UNION will return DISTINCT values, 
-- UNION ALL returns duplicates
-- UNION without same rows returns duplicates
-- UNION combines two select statemets, its required to have same number of rows.