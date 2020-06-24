
-----------------------------------------------------  SORTING and FILTERING on HR Database ----------------------------

-- 1. Write a query in SQL to display the full name (first and last name), and salary for those employees who earn below 6000. 
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name"   
FROM employees
WHERE salary < 6000

-- 2. Write a query in SQL to display the first and last_name, department number and salary for those employees who earn more than 8000. 
SELECT *
FROM employees
WHERE salary > 8000

-- 3. Write a query in SQL to display the first and last name, and department number for all employees whose last name is “McEwen”. 
SELECT *
FROM employees
WHERE LAST_NAME = 'McEwen'

SELECT *
FROM employees
WHERE LAST_NAME LIKE '%McEwen%'

-- 4. Write a query in SQL to display all the information for all employees without any department number. 
SELECT *
FROM employees
WHERE DEPARTMENT_ID IS NULL

-- 5. Write a query in SQL to display all the information about the department Marketing.
SELECT *
FROM employees
WHERE DEPARTMENT_NAME = 'Marketing'

-- 6. Write a query in SQL to display the full name (first and last), hire date, salary, and department number 
	-- for those employees whose first name does not containing the letter M and make the result set in ascending order by department number. 
SELECT *
FROM employees
WHERE FIRST_NAME NOT LIKE '%M%'
ORDER BY DEPARTMENT_ID

SELECT *
FROM employees
WHERE FIRST_NAME NOT LIKE 'M%'
ORDER BY DEPARTMENT_ID

-- 7. Write a query in SQL to display all the information of employees whose salary 
	-- is in the range of 8000 and 12000 and commission is not null or department number is except the number 40, 120 and 70 and they have been hired before June 5th, 1987. 
SELECT *
FROM employees 
WHERE salary BETWEEN 8000 AND 12000 
	AND commission_pct IS NOT NULL 
	OR DEPARTMENT_ID IN(40,120,70) 
	AND HIRE_DATE < '1987.06.05'::date

-- 8. Write a query in SQL to display the full name (first and last name), and salary for all employees who does not earn any commission. 
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", salary
FROM employees
WHERE commission_pct IS NULL 

-- 9. Write a query in SQL to display the full name (first and last), the phone number and email separated by hyphen, and salary, 
	-- for those employees whose salary is within the range of 9000 and 17000. The column headings assign with Full_Name, Contact_Details and Remuneration respectively. 
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", 
	CONCAT(PHONE_NUMBER,'-',email) AS "Contact_Details", 
	salary AS "Remuneration"
FROM employees
WHERE salary BETWEEN 9000 AND 17000

-- 10. Write a query in SQL to display the first and last name, and salary for those employees whose first name is ending with the letter m. 
SELECT *
FROM employees
WHERE FIRST_NAME LIKE '%m'

-- 11. Write a query in SQL to display the full name (first and last) name, and salary, 
 -- for all employees whose salary is out of the range 7000 and 15000 and make the result set in ascending order by the full name.  
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", 
	salary AS "Remuneration"
FROM employees
WHERE salary BETWEEN 7000 AND 15000
ORDER BY "Full Name"

-- 12. Write a query in SQL to display the full name (first and last), job id and date of hire for those employees who was hired during November 5th, 2007 and July 5th, 2009.
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", 
	salary AS "Remuneration"
FROM employees
WHERE HIRE_DATE BETWEEN '2007.11.05'::date AND '2009.06.05'::date

-- 13. Write a query in SQL to display the the full name (first and last name), and department number for those employees who works either in department 70 or 90.
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IN(70,90) 

-- 14. Write a query in SQL to display the full name (first and last name), salary, and manager number for those employees who is working under a manager. 
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", salary, MANAGER_ID 
FROM employees
WHERE MANAGER_ID IS NOT NULL AND MANAGER_ID <> 0

-- 15. Write a query in SQL to display all the information from Employees table for those employees who was hired before June 21st, 2002. 
SELECT *
FROM employees
WHERE HIRE_DATE < '2002.06.21'::date

-- 16. Write a query in SQL to display the first and last name, email, salary and manager ID, for those employees whose managers are hold the ID 120, 103 or 145. 
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", 
	CONCAT(PHONE_NUMBER,'-',email) AS "Contact_Details", 
	MANAGER_ID
FROM employees
WHERE MANAGER_ID IN(120,103,145)

-- 17. Write a query in SQL to display all the information for all employees 
	-- who have the letters D, S, or N in their first name and also arrange the result in descending order by salary.
SELECT *
FROM employees
WHERE FIRST_NAME LIKE '%d%' 
	OR FIRST_NAME LIKE '%s%' 	
	OR FIRST_NAME LIKE '%n%' 
ORDER BY salary DESC

-- 18. Write a query in SQL to display the full name (first name and last name), hire date, commission percentage, email and telephone separated by '-', and salary 
	-- for those employees who earn the salary above 11000 or the seventh digit in their phone number equals 3 and make the result set in a descending order by the first name. 
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", 
	CONCAT(PHONE_NUMBER,'-',email) AS "Contact_Details", 
	salary AS "Remuneration"
FROM employees
WHERE salary > 11000 OR phone_number LIKE '______3%'
ORDER BY FIRST_NAME DESC

SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", 
	CONCAT(PHONE_NUMBER,'-',email) AS "Contact_Details", 
	salary AS "Remuneration"
FROM employees
WHERE salary > 11000 OR SUBSTRING(phone_number, 7, 1) = '3'
ORDER BY FIRST_NAME DESC

-- 19. Write a query in SQL to display the first and last name, and department number for those employees who holds a letter s as a 3rd character in their first name.
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", 
	CONCAT(PHONE_NUMBER,'-',email) AS "Contact_Details", 
	DEPARTMENT_ID
FROM employees
WHERE SUBSTRING(FIRST_NAME, 3, 1) = 's'

-- 20. Write a query in SQL to display the employee ID, first name, job id, and department number for those employees who is working except the departments 50,30 and 80. 
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS "Full Name", 
	CONCAT(PHONE_NUMBER,'-',email) AS "Contact_Details", 
	DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID NOT IN(50, 30, 80) 

-- 21. Write a query in SQL to display the employee Id, first name, job id, and department number for those employees whose department number equals 30, 40 or 90.
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, JOB_ID     
FROM employees
WHERE DEPARTMENT_ID IN(40, 30, 90) 

-- 22. Write a query in SQL to display the ID for those employees who did two or more jobs in the past. 
SELECT EMPLOYEE_ID
FROM job_history
GROUP BY EMPLOYEE_ID
HAVING COUNT(START_DATE) >= 2

-- 23. Write a query in SQL to display job ID, number of employees, sum of salary, and difference between highest salary and lowest salary for a job. 
SELECT JOB_ID, 
	COUNT(EMPLOYEE_ID), 
	SUM(salary), 
	MAX(salary)-MIN(salary)
FROM employees 
GROUP BY JOB_ID

-- 24. Write a query in SQL to display job ID for those jobs that were done by two or more for more than 300 days.  
SELECT JOB_ID
FROM job_history 
WHERE END_DATE - START_DATE > 300
GROUP BY JOB_ID
HAVING COUNT(*) > 1

-- 25. Write a query in SQL to display the country ID and number of cities in that country we have. 
SELECT COUNTRY_ID, COUNT(CITY)
FROM locations
GROUP BY COUNTRY_ID

-- 26. Write a query in SQL to display the manager ID and number of employees managed by the manager. 
SELECT MANAGER_ID, COUNT(EMPLOYEE_ID )
FROM locations
GROUP BY MANAGER_ID

-- 27. Write a query in SQL to display the details of jobs in descending sequence on job title. 
SELECT *
FROM jobs
ORDER BY JOB_TITLE DESC

-- 28. Write a query in SQL to display the first and last name and date of joining of the employees who is either Sales Representative or Sales Man. 
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE  
FROM employees 
WHERE JOB_ID = 'SA_REP' OR JOB_ID = 'SA_MAN'

-- 29. Write a query in SQL to display the average salary of employees for each department who gets a commission percentage. 
SELECT AVG(SALARY), DEPARTMENT_ID
FROM employees 
WHERE COMMISSION_PCT IS NOT NULL OR COMMISSION_PCT = 0
GROUP BY DEPARTMENT_ID

-- 30. Write a query in SQL to display those departments where any manager is managing 4 or more employees.
SELECT DISTINCT DEPARTMENT_ID  
FROM employees 
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) > 3

-- 31. Write a query in SQL to display those departments where more than ten employees work who got a commission percentage.
SELECT DISTINCT DEPARTMENT_ID  
FROM employees 
WHERE (COMMISSION_PCT IS NOT NULL OR COMMISSION_PCT = 0)
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) > 3

-- 32. Write a query in SQL to display the employee ID and the date on which he ended his previous job.
SELECT employee_id, END_DATE
FROM job_history
WHERE END_DATE IN(SELECT MAX(END_DATE)
				FROM job_history
				WHERE END_DATE < (SELECT MAX(END_DATE)
								  FROM job_history))

-- 33. Write a query in SQL to display the details of the employees 
	-- who have no commission percentage and salary within the range 7000 to 12000 and works in that department which number is 50.
SELECT *
FROM employees
WHERE COMMISSION_PCT = 0 
	AND salary BETWEEN 7000 AND 12000 
	AND DEPARTMENT_ID = 50

-- 34. Write a query in SQL to display the job ID for those jobs which average salary is above 8000.
SELECT *
FROM employees
WHERE AVG(salary) > 8000
	
-- 35. Write a query in SQL to display job Title, the difference between minimum and maximum salaries for those jobs which max salary within the range 12000 to 18000. 
SELECT JOB_TITLE, MAX_SALARY - MIN_SALARY 
FROM jobs 
WHERE max_salary BETWEEN 12000 AND 18000

-- 36. Write a query in SQL to display all those employees whose first name or last name starts with the letter D. 
SELECT *
FROM employees
WHERE FIRST_NAME LIKE 'D%' OR LAST_NAME LIKE 'D%'

-- 37. Write a query in SQL to display the details of jobs which minimum salary is greater than 9000.
SELECT *
FROM jobs
WHERE MIN_SALARY > 9000

-- 38. Write a query in SQL to display those employees who joined after 7th September, 1987. 
SELECT *
FROM employees  
WHERE HIRE_DATE > '1987.09.07'::DATE
