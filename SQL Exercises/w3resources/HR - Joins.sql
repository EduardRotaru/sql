

-----------------------------------------------------  JOINS on HR Database --------------------------------------------

-- 1. Write a query in SQL to display the first name, last name, department number, and department name for each employee. 
SELECT e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME      
FROM employees e
LEFT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 

-- 2. Write a query in SQL to display the first and last name, department, city, and state province for each employee.  
SELECT e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT_ID, l.CITY, l.STATE_PROVINCE      
FROM employees e
LEFT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
INNER JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID 

-- 3. Write a query in SQL to display the first name, last name, salary, and job grade for all employees.  
SELECT e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT_ID, e.SALARY, j.GRADE_LEVEL        
FROM employees e, job_grades j
WHERE e.SALARY BETWEEN j.LOWEST_SAL AND j.HIGHEST_SAL
ORDER BY j.GRADE_LEVEL 

-- 4. Write a query in SQL to display the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME   
FROM employees e
LEFT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE d.DEPARTMENT_ID IN(80, 40)

-- 5. Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, l.CITY, l.STATE_PROVINCE    
FROM employees e
INNER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
INNER JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID 
WHERE e.FIRST_NAME LIKE '%z%'

-- 6. Write a query in SQL to display all departments including those where does not have any employee.
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME      
FROM employees e
RIGHT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID  

SELECT d.DEPARTMENT_NAME, COUNT(e.EMPLOYEE_ID)     
FROM employees e
RIGHT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID  
GROUP BY d.DEPARTMENT_NAME
HAVING COUNT(e.EMPLOYEE_ID) > 0

-- 7. Write a query in SQL to display the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT * 
FROM employees e1
INNER JOIN employees e2 ON e1.SALARY < e2.SALARY AND e2.EMPLOYEE_ID = 182 

SELECT *
FROM employees
WHERE SALARY < (SELECT SALARY
			   FROM employees
			   WHERE EMPLOYEE_ID = 182)

-- NOTE:
-- This is new for me, I didn't know I can join like this

-- 8. Write a query in SQL to display the first name of all employees including the first name of their manager.  
SELECT e1.FIRST_NAME, e2.FIRST_NAME "Manager Name"
FROM employees e1
JOIN employees e2 ON e1.MANAGER_ID = e2.EMPLOYEE_ID

-- NOTE AGAIN:
-- I noticed that the order of select columns are prioritized by the order after ON keyword in a join

-- 9. Write a query in SQL to display the department name, city, and state province for each department.  
SELECT d.DEPARTMENT_NAME, l.CITY, l.STATE_PROVINCE    
FROM departments d
INNER JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID

-- 10. Write a query in SQL to display the first name, last name, department number and name, for all employees who have or have not any department.
SELECT e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME   
FROM employees e
LEFT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 

-- 11. Write a query in SQL to display the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT e.FIRST_NAME, managers.FIRST_NAME "Manager Name"
FROM employees e
FULL OUTER JOIN employees managers ON e.EMPLOYEE_ID = managers.MANAGER_ID 

-- 12. Write a query in SQL to display the first name, last name, and department number 
	-- for those employees who works in the same department as the employee who holds the last name as Taylor.  
SELECT e.FIRST_NAME
FROM employees e
INNER JOIN employees e2 ON e.DEPARTMENT_ID = e2.DEPARTMENT_ID AND e.LAST_NAME = 'Taylor'
	
-- 13. Write a query in SQL to display the job title, department name, full name (first and last name ) of employee, 
	-- and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997. 
SELECT j.JOB_TITLE, d.DEPARTMENT_NAME, e.FIRST_NAME, e.LAST_NAME                             
FROM jobs j
INNER JOIN job_history jh ON j.JOB_ID = jh.JOB_ID      
INNER JOIN employees e ON jh.EMPLOYEE_ID = e.EMPLOYEE_ID       
INNER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE START_DATE >= '1993.01.01'::date AND START_DATE <= '1997.08.31'::date

-- 14. Write a query in SQL to display job title, full name (first and last name ) of employee, 
	-- and the difference between maximum salary for the job and salary of the employee. 
SELECT e.FIRST_NAME, e.LAST_NAME, j.MAX_SALARY - e.SALARY AS "Difference"                     
FROM employees e
INNER JOIN jobs j ON e.JOB_ID = j.JOB_ID      

-- 15. Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission. 
SELECT d.DEPARTMENT_NAME, ROUND(AVG(e.SALARY), 2), COUNT(e.EMPLOYEE_ID)
FROM employees e
INNER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
GROUP BY d.DEPARTMENT_NAME

-- 16. Write a query in SQL to display the full name (first and last name ) of employees, job title and 
	-- the salary differences to their own job for those employees who is working in the department ID 80.
SELECT e.FIRST_NAME, e.LAST_NAME, j.JOB_TITLE, j.MAX_SALARY - e.SALARY              
FROM employees e
INNER JOIN jobs j ON e.JOB_ID = j.JOB_ID    
WHERE e.DEPARTMENT_ID = 80
	
-- 17. Write a query in SQL to display the name of the country, city, and the departments which are running there. 
SELECT c.COUNTRY_NAME, l.CITY, d.DEPARTMENT_NAME                                              
FROM countries c
INNER JOIN locations l ON c.COUNTRY_ID  = l.COUNTRY_ID     
INNER JOIN departments d ON l.LOCATION_ID = d.LOCATION_ID 

-- 18. Write a query in SQL to display department name and the full name (first and last name) of the manager.  
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME                                              
FROM departments d
INNER JOIN employees e ON d.MANAGER_ID = e.EMPLOYEE_ID 

-- 19. Write a query in SQL to display job title and average salary of employees.  
SELECT j.JOB_TITLE, ROUND(AVG(e.SALARY),2)
FROM employees e
INNER JOIN jobs j ON e.JOB_ID = j.JOB_ID     
GROUP BY j.JOB_TITLE

-- 20. Write a query in SQL to display the details of jobs which was done by any of the employees who is presently earning a salary on and above 12000.  
SELECT *
FROM employees e
INNER JOIN job_history j ON e.EMPLOYEE_ID  = j.EMPLOYEE_ID      
WHERE e.SALARY >= 12000

-- Check this again
-- 21. Write a query in SQL to display the country name, city, and number of those departments where at leaste 2 employees are working.
SELECT c.COUNTRY_NAME, l.CITY                   
FROM countries c
INNER JOIN locations l ON c.COUNTRY_ID = l.COUNTRY_ID 
INNER JOIN departments d ON l.LOCATION_ID = d.LOCATION_ID 
INNER JOIN employees e ON d.DEPARTMENT_ID  = e.DEPARTMENT_ID 
GROUP BY c.COUNTRY_NAME, l.CITY
HAVING COUNT(*) >= 2

-- 22. Write a query in SQL to display the department name, full name (first and last name) of manager, and their city. 
SELECT e.FIRST_NAME, e.LAST_NAME, l.CITY, d.DEPARTMENT_NAME                 
FROM employees e
INNER JOIN departments d ON e.EMPLOYEE_ID = d.MANAGER_ID   
INNER JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID   

-- 23. Write a query in SQL to display the employee ID, job name, number of days worked in for all those jobs in department 80. 
SELECT jh.EMPLOYEE_ID, j.JOB_TITLE, COUNT(jh.JOB_ID), jh.END_DATE - jh.START_DATE AS "DaysWorked"
FROM jobs j
INNER JOIN job_history jh ON j.JOB_ID = jh.JOB_ID  
WHERE jh.DEPARTMENT_ID = 80
GROUP BY jh.EMPLOYEE_ID, j.JOB_TITLE, "DaysWorked"

-- 24. Write a query in SQL to display the full name (first and last name), and salary of those employees who working in any department located in London.
SELECT *
FROM employees e
INNER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID     
INNER JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID   
WHERE l.CITY = 'London'

-- 25. Write a query in SQL to display full name(first and last name), job title, starting 
	-- and ending date of last jobs for those employees with worked without a commission percentage. 
SELECT e.FIRST_NAME, e.LAST_NAME, j.JOB_TITLE, jh.START_DATE, jh.END_DATE                         
FROM jobs j
INNER JOIN job_history jh ON j.JOB_ID = jh.JOB_ID        
INNER JOIN employees e ON jh.EMPLOYEE_ID = e.EMPLOYEE_ID       
WHERE e.COMMISSION_PCT = 0

-- 26. Write a query in SQL to display the department name and number of employees in each of the department. 
SELECT d.DEPARTMENT_NAME, COUNT(*)                
FROM employees e
INNER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID   
GROUP BY d.DEPARTMENT_NAME
ORDER BY COUNT(*) 

-- 27. Write a query in SQL to display the full name (firt and last name ) of employee with ID and name of the country presently where (s)he is working.
SELECT e.FIRST_NAME, e.LAST_NAME, e.EMPLOYEE_ID, c.COUNTRY_NAME                      
FROM countries c
INNER JOIN locations l ON c.COUNTRY_ID = l.COUNTRY_ID 
INNER JOIN departments d ON l.LOCATION_ID = d.LOCATION_ID 
INNER JOIN employees e ON d.DEPARTMENT_ID  = e.DEPARTMENT_ID 