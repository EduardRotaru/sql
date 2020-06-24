
-----------------------------------------------------  SUBQUERIES on HR Database ---------------------------------------

-- 1. Write a query to display the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT FIRST_NAME, LAST_NAME   
FROM employees
WHERE salary > (SELECT salary
			   FROM employees
			   WHERE EMPLOYEE_ID = 163)

-- 2. Write a query to display the name ( first name and last name ), salary, department id, job id 
	-- for those employees who works in the same designation as the employee works whose id is 169.  
SELECT * 
FROM employees
WHERE JOB_ID IN(SELECT JOB_ID
			   FROM employees
			   WHERE EMPLOYEE_ID = 169)
			   
-- 3. Write a query to display the name ( first name and last name ), salary, department id 
	-- for those employees who earn such amount of salary which is the smallest salary of any of the departments. 
SELECT * 
FROM employees
WHERE SALARY IN(SELECT MIN(SALARY)   
			   FROM employees
			   GROUP BY DEPARTMENT_ID) -- IS grouped by department_id because we want to find out the smallest salary by the department

-- 4. Write a query to display the employee id, employee name (first name and last name ) for all employees who earn more than the average salary. 
SELECT * 
FROM employees 
WHERE SALARY > (SELECT AVG(SALARY)
			   FROM employees)

-- 5. Write a query to display the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.  
SELECT * 
FROM employees 
WHERE MANAGER_ID IN(SELECT EMPLOYEE_ID
			   	FROM employees
				WHERE FIRST_NAME = 'Payam')
				
-- 6. Write a query to display the department number, name ( first name and last name ), job and department name for all employees in the Finance department. 
SELECT * 
FROM employees 
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID 
			   	FROM departments
				WHERE DEPARTMENT_NAME = 'Finance')
				
SELECT * 
FROM employees
INNER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE d.DEPARTMENT_NAME = 'Finance'

-- 7. Write a query to display all the information of an employee whose salary and reporting person id is 3000 and 121 respectively. 
SELECT * 
FROM employees
WHERE EMPLOYEE_ID IN(SELECT EMPLOYEE_ID  
					FROM employees
					WHERE SALARY = 3000 AND MANAGER_ID = 121)

-- 8. Display all the information of an employee whose id is any of the number 134, 159 and 183.   
SELECT * 
FROM employees
WHERE EMPLOYEE_ID IN(134,159,183)
					
-- 9. Write a query to display all the information of the employees whose salary is within the range 1000 and 3000.   
SELECT * 
FROM employees
WHERE SALARY BETWEEN 1000 AND 3000

-- 10. Write a query to display all the information of the employees whose salary is within the range of smallest salary and 2500.  
SELECT * 
FROM employees
WHERE SALARY BETWEEN (SELECT MIN(SALARY)
							  FROM employees) AND 2500

-- 11. Write a query to display all the information of the employees 
	-- who does not work in those departments where some employees works whose manager id within the range 100 and 200.   
SELECT * 
FROM employees
WHERE DEPARTMENT_ID NOT IN(SELECT DEPARTMENT_ID 
					FROM departments
					WHERE MANAGER_ID BETWEEN 100 AND 200) 

-- 12. Write a query to display all the information for those employees whose id is any id who earn the second highest salary.  
SELECT * 
FROM employees
WHERE SALARY =(SELECT MAX(SALARY)
					FROM employees
			  		WHERE SALARY < (SELECT MAX(SALARY)
									FROM employees))

-- 13. Write a query to display the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
SELECT first_name, last_name, hire_date
FROM employees 
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID 
						FROM employees
						WHERE EMPLOYEE_ID =(SELECT EMPLOYEE_ID
										   FROM employees
										   WHERE FIRST_NAME = 'Clara')) 
EXCEPT 
SELECT first_name, last_name, hire_date
	   FROM employees
	   WHERE FIRST_NAME = 'Clara'

-- 14. Write a query to display the employee number and name( first name and last name ) 
	-- for all employees who work in a department with any employee whose name contains a T.  
SELECT first_name, last_name, hire_date
FROM employees 
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
					FROM employees 
					WHERE FIRST_NAME LIKE '%T%')

-- 15. Write a query to display the employee number, name( first name and last name ), and salary 
	-- for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT *
FROM employees 
WHERE SALARY > (SELECT AVG(SALARY)
				FROM employees)
					AND DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
									  FROM employees
									  WHERE FIRST_NAME LIKE '%J%')

-- 16. Display the employee name( first name and last name ), employee id, and job title for all employees whose department location is Toronto.
SELECT *
FROM employees 
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
					FROM departments 
					WHERE LOCATION_ID IN(SELECT LOCATION_ID 
										FROM locations
										WHERE CITY = 'Toronto'))
										
SELECT *
FROM employees 
INNER JOIN departments ON employees.DEPARTMENT_ID = departments.DEPARTMENT_ID
INNER JOIN locations ON locations.LOCATION_ID = departments.LOCATION_ID
WHERE locations.CITY = 'Toronto'

-- 17. Write a query to display the employee number, name( first name and last name ) and job title for all employees 
	-- whose salary is smaller than any salary of those employees whose job title is MK_MAN. 
SELECT *
FROM employees 
WHERE SALARY < ANY(SELECT SALARY
				FROM employees 
				WHERE JOB_ID = 'MK_MAN')

-- 18. Write a query to display the employee number, name( first name and last name ) and job title for all employees 
	-- whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT *
FROM employees 
WHERE SALARY < ANY(SELECT SALARY
				FROM employees 
				WHERE JOB_ID = 'MK_MAN') 
					AND JOB_ID <> 'MK_MAN'
EXCEPT 
SELECT *
FROM employees 
WHERE JOB_ID = 'MK_MAN'

-- 19. Write a query to display the employee number, name( first name and last name ) and job title for all employees 
	-- whose salary is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN. 
SELECT *
FROM employees 
WHERE SALARY > ANY(SELECT SALARY
				FROM employees 
				WHERE JOB_ID = 'PU_MAN')
EXCEPT 
SELECT *
FROM employees 
WHERE JOB_ID = 'PU_MAN'

-- 20. Write a query to display the employee number, name( first name and last name ) and job title for all employees 
	-- whose salary is more than any average salary of any department. 
SELECT *
FROM employees 
WHERE SALARY > ANY(SELECT AVG(SALARY)
				FROM employees 
				GROUP BY DEPARTMENT_ID)
				
-- 21. Write a query to display the employee name( first name and last name ) and department for all employees for 
	-- any existence of those employees whose salary is more than 3700. 
SELECT *
FROM employees 
WHERE EXISTS(SELECT SALARY
			FROM employees 
			WHERE SALARY > 3700)

-- 22. Write a query to display the department id and the total salary for those departments which contains at least one employee. 
SELECT departments.DEPARTMENT_ID, SUM(employees.SALARY)
FROM employees
INNER JOIN departments ON employees.DEPARTMENT_ID = departments.DEPARTMENT_ID
GROUP BY departments.DEPARTMENT_ID
HAVING COUNT(*) > 0
ORDER BY 1

-- 23. Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN 
	-- for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG. 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,   
CASE JOB_ID
	WHEN 'ST_MAN' THEN 'SALESMAN'	
	WHEN 'IT_PROG' THEN 'DEVELOPER'
ELSE JOB_ID
END AS JOB_NAME, SALARY   
FROM employees

-- 24. Write a query to display the employee id, name ( first name and last name ), salary 
	-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees. 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY,
CASE 
	WHEN SALARY > (SELECT AVG(SALARY)
				  FROM employees)  
				  THEN 'HIGH'	
	WHEN SALARY < (SELECT AVG(SALARY)
				  FROM employees)   
				  THEN 'LOW'
END AS SalaryStatus
FROM employees
ORDER BY SALARY DESC

-- 25. Write a query to display the employee id, name ( first name and last name ), 
	-- SalaryDrawn, AvgCompare (salary - the average salary of all employees) 
	-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, SALARY - (SELECT AVG(SALARY) 
															FROM employees) AS AvgCompare, 
CASE 
	WHEN SALARY > (SELECT AVG(SALARY)
				  FROM employees)  
				  THEN 'HIGH'	
	WHEN SALARY < (SELECT AVG(SALARY)
				  FROM employees)   
				  THEN 'LOW'
END AS SalaryStatus
FROM employees
ORDER BY SALARY DESC

-- 26. Write a subquery that returns a set of rows to find all departments that do actually have one or more employees assigned to them.  
SELECT *
FROM departments
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
						FROM employees)

-- 27. Write a query that will identify all employees who work in departments located in the United Kingdom. 
SELECT *
FROM employees
INNER JOIN departments ON employees.DEPARTMENT_ID = departments.DEPARTMENT_ID
INNER JOIN locations ON departments.LOCATION_ID = locations.LOCATION_ID
INNER JOIN countries ON locations.COUNTRY_ID = countries.COUNTRY_ID
WHERE countries.COUNTRY_NAME = 'United Kingdom'

-- 28. Write a query to identify all the employees who earn more than the average and who work in any of the IT departments.
SELECT *
FROM employees
WHERE SALARY > (SELECT AVG(SALARY)
				FROM employees)
					AND DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
						FROM departments
						WHERE DEPARTMENT_NAME LIKE '%IT%')

-- 29. Write a query to determine who earns more than Mr. Ozer. 
SELECT *
FROM employees
WHERE SALARY > (SELECT SALARY
				FROM employees
				WHERE LAST_NAME = 'Ozer')

-- 30. Write a query to find out which employees have a manager who works for a department based in the US.
SELECT *
FROM employees
WHERE MANAGER_ID IN(SELECT MANAGER_ID 
				FROM departments
				WHERE LOCATION_ID IN(SELECT LOCATION_ID 
									FROM locations
									WHERE COUNTRY_ID = 'US'))

-- 31. Write a query which is looking for the names of all employees whose salary is greater than 50% of their department’s total salary bill. 
SELECT *
FROM employees
WHERE SALARY > IN(SELECT SUM(SALARY)*0.5 -- percent can be expressed as 0.X
			   FROM employees
			   GROUP BY DEPARTMENT_ID)
		
-- Something I have learned here, I can use a select in a JOIN
SELECT *
FROM employees e1
JOIN (SELECT DEPARTMENT_ID, SUM(SALARY)*.5 AS Bill -- percent can be expressed as 0.X
	   FROM employees
	   GROUP BY DEPARTMENT_ID) e2
ON e1.DEPARTMENT_ID = e2.DEPARTMENT_ID
WHERE e1.SALARY > e2.Bill

-- 32. Write a query to get the details of employees who are managers.  
SELECT *
FROM employees e
JOIN (SELECT *
	  FROM departments) managers
ON e.EMPLOYEE_ID = managers.MANAGER_ID 

SELECT *
FROM employees e
JOIN departments m
ON e.EMPLOYEE_ID = m.MANAGER_ID 

-- 33. Write a query to get the details of employees who manage a department. 
SELECT *
FROM employees e
INNER JOIN departments m
ON e.EMPLOYEE_ID = m.MANAGER_ID 

-- 34. Write a query to display the employee id, name ( first name and last name ), salary, department name and city for 
	-- all the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003. 
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, l.CITY                
FROM employees e
INNER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
INNER JOIN locations l ON l.LOCATION_ID = d.LOCATION_ID 
WHERE SALARY = (SELECT MAX(SALARY)
			   FROM employees
			   WHERE HIRE_DATE BETWEEN '2002.01.01'::date AND '2003.12.31'::date)

-- 35. Write a query in SQL to display the department code and name for all departments which located in the city London. 
SELECT d.DEPARTMENT_NAME, d.DEPARTMENT_ID           
FROM departments d
INNER JOIN locations l ON l.LOCATION_ID = d.LOCATION_ID 
WHERE l.CITY = 'London'

-- 36. Write a query in SQL to display the first and last name, salary, and department ID for 
	-- all those employees who earn more than the average salary and arrange the list in descending order on salary. 
SELECT e.FIRST_NAME, e.LAST_NAME, e.LAST_NAME, e.DEPARTMENT_ID
FROM employees e
WHERE SALARY > (SELECT AVG(SALARY)
				FROM employees e)
ORDER BY SALARY DESC

-- 37. Write a query in SQL to display the first and last name, salary, and department ID for 
	-- those employees who earn more than the maximum salary of a department which ID is 40.  
SELECT e.FIRST_NAME, e.LAST_NAME, e.LAST_NAME, e.SALARY, e.DEPARTMENT_ID
FROM employees e
WHERE SALARY > (SELECT MAX(SALARY)
				FROM employees e
				WHERE DEPARTMENT_ID = 40)

-- 38. Write a query in SQL to display the department name and Id for 
	-- all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM departments
WHERE LOCATION_ID IN(SELECT LOCATION_ID
				  FROM departments
				  WHERE DEPARTMENT_ID = 30)
ORDER BY DEPARTMENT_ID

-- 39. Write a query in SQL to display the first and last name, salary, and department ID for 
	-- all those employees who work in that department where the employee works who hold the ID 201. 
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
					  FROM departments
					  WHERE EMPLOYEE_ID = 201)

-- 40. Write a query in SQL to display the first and last name, salary, and department ID for 
	-- those employees whose salary is equal to the salary of the employee who works in that department which ID is 40. 
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
					  FROM departments
					  WHERE EMPLOYEE_ID = 201)

-- 41. Write a query in SQL to display the first and last name, and department code for all employees who work in the department Marketing.  
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
					  FROM departments
					  WHERE DEPARTMENT_NAME = 'Marketing')

-- 42.Write a query in SQL to display the first and last name, salary, and department ID for those employees 
	-- who earn more than the minimum salary of a department which ID is 40.  
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees
WHERE SALARY > (SELECT MIN(SALARY)
				  FROM employees
				  WHERE DEPARTMENT_ID = 40)

-- 43. Write a query in SQL to display the full name,email, and designation for all those employees who was hired after the employee whose ID is 165. 
SELECT FIRST_NAME, LAST_NAME, EMAIL, JOB_ID     
FROM employees
WHERE EMPLOYEE_ID IN(SELECT EMPLOYEE_ID 
					  FROM employees
					  WHERE HIRE_DATE > (SELECT HIRE_DATE
										FROM employees
										WHERE EMPLOYEE_ID = 165)) 
				  
-- 44. Write a query in SQL to display the first and last name, salary, and department ID 
	-- for those employees who earn less than the minimum salary of a department which ID is 70.  
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID     
FROM employees
WHERE SALARY < (SELECT MIN(SALARY)
			   FROM employees
			   WHERE DEPARTMENT_ID = 70)

-- 45. Write a query in SQL to display the first and last name, salary, and department ID for those employees 
	-- who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID     
FROM employees
WHERE SALARY < (SELECT AVG(SALARY)
			   FROM employees) 
					AND DEPARTMENT_ID = (SELECT DEPARTMENT_ID
										  FROM employees
										  WHERE FIRST_NAME = 'Laura')

-- 46. Write a query in SQL to display the first and last name, salary and department ID for those employees whose department is located in the city London. 
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID     
FROM employees
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
			   			FROM departments
					 	WHERE LOCATION_ID = (SELECT LOCATION_ID
											FROM locations
											WHERE CITY = 'London')) 

-- 47. Write a query in SQL to display the city of the employee whose ID 134 and works there.
SELECT CITY                
FROM locations
WHERE LOCATION_ID IN(SELECT LOCATION_ID
			   			FROM departments
					 	WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
												FROM employees
												WHERE EMPLOYEE_ID = 134)) 

-- 48. Write a query in SQL to display the the details of those departments which max salary is 7000 or above for those employees who already done one or more jobs. 
SELECT *                
FROM departments
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
					  FROM employees
					  WHERE 7000 < (SELECT MAX(SALARY)
									 FROM employees
					  				 WHERE EMPLOYEE_ID IN(SELECT EMPLOYEE_ID 
											   			FROM job_history)))
														
SELECT *                
FROM departments
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
					  FROM employees
					  WHERE EMPLOYEE_ID IN(SELECT EMPLOYEE_ID
										  FROM job_history
										  GROUP BY EMPLOYEE_ID
										  HAVING COUNT(EMPLOYEE_ID) > 1)
					  GROUP BY DEPARTMENT_ID
					  HAVING MAX(SALARY) > 7000)

-- 49. Write a query in SQL to display the detail information of those departments which starting salary is at least 8000. 
SELECT DEPARTMENT_NAME      
FROM departments d
INNER JOIN employees e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID 
GROUP BY DEPARTMENT_NAME
HAVING MIN(SALARY) >= 8000

-- 50. Write a query in SQL to display the full name (first and last name) of manager who is supervising 4 or more employees.  
SELECT FIRST_NAME, LAST_NAME   
FROM employees
WHERE EMPLOYEE_ID IN(SELECT MANAGER_ID 
				   	FROM employees
				   	GROUP BY MANAGER_ID
				   	HAVING COUNT(EMPLOYEE_ID) >= 4)

-- 51. Write a query in SQL to display the details of the current job for those employees who worked as a Sales Representative in the past. 
SELECT * 
FROM employees
WHERE EMPLOYEE_ID IN(SELECT EMPLOYEE_ID 
					FROM job_history 
					WHERE JOB_ID =(SELECT JOB_ID     
								  FROM jobs
								  WHERE JOB_TITLE = 'Sales Representative'))

-- 52. Write a query in SQL to display all the infromation about those employees who earn second lowest salary of all the employees. 
SELECT * 
FROM employees
WHERE EMPLOYEE_ID IN(SELECT EMPLOYEE_ID 
					FROM employees 
					WHERE SALARY = (SELECT MIN(SALARY) 
									FROM employees 
									WHERE SALARY > (SELECT MIN(SALARY) 
													FROM employees)))

-- 53. Write a query in SQL to display the details of departments managed by Susan.  
SELECT * 
FROM departments
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
						FROM employees
					    WHERE FIRST_NAME = 'Susan')

-- 54. Write a query in SQL to display the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.  
SELECT * 
FROM employees
WHERE (DEPARTMENT_ID, SALARY) IN(SELECT DEPARTMENT_ID, MAX(SALARY)
							   FROM employees
							   GROUP BY DEPARTMENT_ID)

-- 55. Write a query in SQL to display all the information of those employees who did not have any job in the past. 
SELECT * 
FROM employees
WHERE EMPLOYEE_ID NOT IN(SELECT EMPLOYEE_ID
						FROM job_history)