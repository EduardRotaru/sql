
-----------------------------------------------------  employee DATABASE ------------------------------------------------
-------- QUERIES DO NOT CORESPOND WITH ANY OF THE TABLES HERE, SOLVED AND COPY PASTED FROM THE WEBSITE EDITOR.

-- 1. Write a query in SQL to display all the information of the employees. 
SELECT * 
FROM employees

-- 2. Write a query in SQL to find the salaries of all employees.
SELECT salary
FROM employees

-- 3. Write a query in SQL to display the unique designations for the employees.
SELECT job_name  
FROM employees

-- 4. Write a query in SQL to list the emp_name and salary is increased by 15% and expressed as no.of Dollars. 
SELECT emp_name, salary * 0.15
FROM employees

SELECT emp_name, to_char((salary * 0.15) + salary, '$99,999')
FROM employees

-- 5. Write a query in SQL to produce the output of employees name and job name as a fromat of "Employee & Job". 
SELECT concat(emp_name,', ', job_name) AS "Employee & Job"
FROM employees

-- 6. Write a query in SQL to produce the output of employees as follows.   
-- 		Employee
-- 		JONAS(manager).
SELECT concat(emp_name,'(',LOWER(job_name),')') AS "Employee"
FROM employees

-- 7. Write a query in SQL to list the employees with Hire date in the format like February 22, 1991.
SELECT TO_CHAR(hire_date :: DATE, 'Month dd, yyyy')
FROM employees

-- 8. Write a query in SQL to count the no. of characters with out considering the spaces for each name.  
SELECT emp_name, LENGTH(TRIM(emp_name))
FROM employees

-- 9. Write a query in SQL to list the emp_id,salary, and commission of all the employees.
SELECT emp_id, salary,commission
FROM employees

-- 10. Write a query in SQL to display the unique department with jobs. 
SELECT DISTINCT dep_id, job_name  
FROM employees

-- 11. Write a query in SQL to list the employees who does not belong to department 2001.
SELECT *  
FROM employees
WHERE dep_id <> 2001

-- 12. Write a query in SQL to list the employees who joined before 1991. 
SELECT *  
FROM employees
WHERE date_part('year', hire_date) = 1991;

-- 13. Write a query in SQL to display the average salaries of all the employees who works as ANALYST. 
SELECT emp_name, AVG(salary)
FROM employees
WHERE job_name = 'ANALYST'
GROUP BY emp_name

-- 14. Write a query in SQL to display the details of the employee BLAZE.
SELECT *
FROM employees
WHERE emp_name = 'BLAZE'

-- 15. Write a query in SQL to display all the details of the employees whose commission is more than their salary. 
SELECT *
FROM employees
WHERE commission > salary

-- 16. Write a query in SQL to list the employees whose salary is more than 3000 after giving 25% increment. 
SELECT *
FROM employees
WHERE salary + (salary * 0.25) > 3000

-- 17. Write a query in SQL to list the name of the employees, those having six characters to their name. 
SELECT emp_name
FROM employees
WHERE LENGTH(TRIM(emp_name)) = 6

-- 18. Write a query in SQL to list the employees who joined in the month January.  
SELECT emp_name
FROM employees
WHERE date_part('month', hire_date) = 'January'

-- 19. Write a query in SQL to list the name of employees and their manager separated by the string 'works for'.
SELECT emp_name || ' woks for ' || manager_id 
FROM employees

SELECT CONCAT(emp_name, ' woks for ', manager_id) 
FROM employees

-- 20. Write a query in SQL to list all the employees whose designation is CLERK. 
SELECT *
FROM employees
WHERE job_name = 'CLERK'

-- 21. Write a query in SQL to list the employees whose experience is more than 27 years.  
SELECT *
FROM employees
WHERE DATE_PART('year', CURRENT_DATE) - DATE_PART('year', hire_date) > 27

-- 22. Write a query in SQL to list the employees whose salaries are less than 3500.  
SELECT *
FROM employees
WHERE salary < 3500

-- 23. Write a query in SQL to list the name, job_name, and salary of any employee whose designation is ANALYST.
SELECT emp_name, job_name, salary  
FROM employees
WHERE job_name = 'ANALYST'

-- 24. Write a query in SQL to list the employees who have joined in the year 1991.
SELECT *
FROM employees
WHERE DATE_PART('year', hire_date) = 1991;

-- 25. Write a query in SQL to list the name, id, hire_date, and salary of all the employees joined before 1 apr 91. 
SELECT emp_name, job_name, salary  
FROM employees
WHERE hire_date < '1991.04.01'::date

-- 26. Write a query in SQL to list the employee name, and job_name who are not working under a manager. 
SELECT emp_name, job_name  
FROM employees
WHERE manager_id IS NULL

-- 27. Write a query in SQL to list all the employees joined on 1st may 91
SELECT emp_name, job_name, salary  
FROM employees
WHERE hire_date = '1991.05.01'::date

-- 28. Write a query in SQL to list the id, name, salry, and experiences of all the employees working for the manger 68319. 
SELECT emp_name, job_name, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', hire_date) AS "Years of Experience"  
FROM employees
WHERE manager_id = 68319

SELECT emp_name, job_name, age(CURRENT_DATE, hire_date) AS "Years of Experience"  
FROM employees
WHERE manager_id = 68319

-- 29. Write a query in SQL to list the id, name, salary, and experience of all the employees who earn more than 100 as daily salary.  
SELECT emp_id, emp_name, job_name, salary, age(CURRENT_DATE, hire_date) AS "Experience", (salary / 31)::money AS "Salary per day"
FROM employees
WHERE salary / 30 > 100 

-- 30. Write a query in SQL to list the employees who are retiring after 31-Dec-99 after completion of 8 years of service period.  
SELECT *
FROM employees
WHERE EXTRACT 
	(year FROM 
	   age('1999.12.31', hire_date)) >= 8
	   
SELECT *
FROM employees
WHERE hire_date + interval '8 years' > '1999.12.31'

-- 31. Write a query in SQL to list those employees whose salary is an odd value. 
SELECT *
FROM employees
WHERE salary % 2 <> 0

SELECT *
FROM employees
WHERE mod(salary, 2) <> 0

-- 32. Write a query in SQL to list those employees whose salary contain only 3 digits.
SELECT *
FROM employees
WHERE LENGTH(salary::integer::text) = 3

-- 33. Write a query in SQL to list the employees who joined in the month of APRIL.  
SELECT *
FROM employees
WHERE DATE_PART('month', hire_date) = 4;

-- 34. Write a query in SQL to list the employees those who joined in company before 19th of the month.
SELECT *
FROM employees
WHERE DATE_PART('day', hire_date) < 19;

-- 35. Write a query in SQL to list the employees who are SALESMAN and gathered an experience over 10 years.
SELECT *
FROM employees
WHERE job_name = 'SALESMAN' AND 
	EXTRACT ('year' FROM 
			 age(CURRENT_DATE, hire_date)) > 10

-- 36. Write a query in SQL to list the employees of department id 3001 or 1001 joined in the year 1991. 
SELECT *
FROM employees
WHERE DATE_PART('day', hire_date) < 19;

-- 37. Write a query in SQL to list the employees of department id 3001 or 1001 joined in the year 1991.
SELECT *
FROM employees
WHERE department IN(3001, 1001) AND DATE_PART('year', hire_date) = 1991;

-- 38. Write a query in SQL to list all the employees of designation CLERK in department no 2001. 
SELECT *
FROM employees
WHERE job_name = 'CLERK' AND dep_id = '2001'

-- 39. Write a query in SQL to list the ID, name, salary, and job_name of the employees for 
-- 		1. Annual salary is below 34000 but receiving some commission which should not be more than the salary,
-- 		2. And designation is SALESMAN and working for department 3001.
SELECT *
FROM employees
WHERE salary < 34000 
	AND commission IS NOT NULL
	AND commission < salary
	AND job_name = 'SALESMAN' 
	AND dep_id = '3001'

-- 40. Write a query in SQL to list the employees who are either CLERK or MANAGER.  
SELECT *
FROM employees
WHERE job_name = 'CLERK' OR job_name = 'MANAGER'

-- 41. Write a query in SQL to list the employees who joined in any year except the month February. 
SELECT *
FROM employees
WHERE DATE_PART('month', hire_date) <> 2;

-- 42. Write a query in SQL to list the employees who joined in the year 91. 
SELECT *
FROM employees
WHERE DATE_PART('year', hire_date) = 1991;

-- 43. Write a query in SQL to list the employees who joined in the month of June in 1991.
SELECT *
FROM employees
WHERE DATE_PART('year', hire_date) = 1991 
	AND DATE_PART('month', hire_date) = 6;

-- 44. Write a query in SQL to list the employees whose annual salary is within the range 24000 and 50000. 
SELECT *
FROM employees
WHERE salary*12 BETWEEN 24000 AND 50000

-- 45. Write a query in SQL to list the employees who have joined on the following dates 1st May,20th Feb, and 03rd Dec in the year 1991.
SELECT *
FROM employees
WHERE hire_date IN('1991.05.01'::date,
				 '1991.02.20'::date, 
				 '1991.12.03'::date);
	
-- 46. Write a query in SQL to list the employees working under the managers 63679,68319,66564,69000.
SELECT *
FROM employees
WHERE manager_id IN(63679,68319,66564,69000)
				 
-- 47. Write a query in SQL to list the employees who joined after the month JUNE in the year 1991. 
SELECT *
FROM employees
WHERE DATE_PART('month', hire_date) >= 6 AND DATE_PART('year', hire_date) = 1991

-- 48. Write a query in SQL to list the employees who joined in 90's. 
SELECT *
FROM employees
WHERE DATE_PART('year', hire_date) BETWEEN 1990 AND 1999

-- 49. Write a query in SQL to list the managers of department 1001 or 2001. 
SELECT *
FROM employees
WHERE dep_id IN(1001, 2001) AND job_name = 'MANAGER'

-- 50. Write a query in SQL to list the employees, joined in the month FEBRUARY with a salary range between 1001 to 2000.
SELECT *
FROM employees
WHERE salary BETWEEN 1001 AND 2000 AND DATE_PART('month', hire_date) = 2

-- 51. Write a query in SQL to list all the employees who joined before or after 1991.
SELECT *
FROM employees
WHERE DATE_PART('year', hire_date) <> 1991

-- 52. Write a query in SQL to list the employees along with department name.
SELECT e.emp_name, d.dep_name  
FROM employees e
LEFT JOIN department d ON d.dep_id = e.dep_id

-- 53. Write a query in SQL to list the name, job name, annual salary, department id, department name and grade of the employees 
		-- who earn 60000 in a year or not working as an ANALYST.
SELECT e.emp_name, e.job_name, e.salary, e.dep_id, d.dep_name, s.grade
FROM employees e, salary_grade s, department d
WHERE d.dep_id = e.dep_id 
	AND (salary*12 >= 60000 OR job_name <> 'ANALYST') 
	AND e.salary BETWEEN s.min_sal AND s.max_sal

-- 54. Write a query in SQL to list the name, job name, manager id, salary, manager name, manager's salary 
	-- for those employees whose salary is greater than the salary of their managers. 
SELECT e.emp_name, e.job_name, e.salary, e.dep_id
FROM employees e, employees manager
WHERE e.emp_id = manager.manager_id 
	AND manager.salary > e.salary

-- 55. Write a query in SQL to list the employees name, department, salary and commission. For those whose salary is between 2000 and 5000 while location is PERTH. 
SELECT e.emp_name, e.job_name, e.salary, e.dep_id
FROM employees e
INNER JOIN department d ON e.dep_id = d.dep_id
WHERE e.salary BETWEEN 2000 AND 5000 and d.dep_location = 'PERTH'

SELECT e.emp_name, e.job_name, e.salary, e.dep_id
FROM employees e, department d 
WHERE e.dep_id = d.dep_id 
	AND e.salary BETWEEN 2000 AND 5000 
	AND d.dep_location = 'PERTH'

-- 56. Write a query in SQL to list the grade, employee name for the department id 1001 or 3001 but salary grade is not 4 while they joined the company before 1992-12-31.
SELECT s.grade, e.emp_name
FROM employees e, salary_grade s 
WHERE dep_id IN(1001, 3001) 
	AND e.hire_date < '1992-12-31'::date
	AND (e.salary BETWEEN s.min_sal AND s.max_sal 
		 AND s.grade <> 4)
ORDER BY s.grade

-- 57. Write a query in SQL to list the employees whose manager name is JONAS.
SELECT *
FROM employees
WHERE manager_id IN(
	SELECT emp_id
	FROM employees 
	WHERE emp_name = 'JONAS')

-- 58. Write a query in SQL to list the name and salary of FRANK if his salary is equal to max_sal of his grade. 
SELECT e.emp_name, e.salary
FROM employees e, salary_grade d
WHERE e.emp_name = 'FRANK' 
	AND e.salary = d.max_sal 
	AND e.salary BETWEEN d.min_sal AND d.max_sal

-- 59. Write a query in SQL to list the employees who are working either MANAGER or ANALYST with a salary range between 2000 to 5000 without any commission. 
SELECT *
FROM employees e, salary_grade d
WHERE (job_name = 'MANAGER' OR job_name = 'ANALYST')
	AND salary BETWEEN 2000 AND 5000
	AND commission IS NULL
	
-- 60. Write a query in SQL to list the id, name, salary, and location of the employees working at PERTH,or MELBOURNE with an experience over 10 years.
SELECT *
FROM employees e, department d
WHERE e.dep_id = d.dep_id 
	AND d.dep_location IN('PERTH','MELBOURNE')
	AND EXTRACT('year' 
		FROM age(CURRENT_DATE, e.hire_date)) > 10
	
-- 61. Write a query in SQL to list the employees along with their location who belongs to SYDNEY, MELBOURNE with a salary range between 2000 and 5000 and joined in 1991.
SELECT *
FROM employees e, department d
WHERE e.dep_id = d.dep_id 
	AND d.dep_location IN('SYDNEY','MELBOURNE')
	AND e.salary BETWEEN 2000 AND 5000
	AND DATE_PART('year', hire_date) = 1991
	
-- 62. Write a query in SQL to list the employees with their location and grade for MARKETING department who comes from MELBOURNE or PERTH 
		-- within the grade 3 to 5 and experience over 5 years.
SELECT *
FROM employees e, department d, salary_grade s
WHERE e.dep_id = d.dep_id 
	AND d.dep_location IN('PERTH','MELBOURNE')
	AND d.dep_name = 'MARKETING'
	AND (s.grade IN(3, 5) 
		 AND e.salary BETWEEN s.min_sal AND s.max_sal)	
	AND EXTRACT('year' 
		FROM age(CURRENT_DATE, e.hire_date)) > 5
	
-- 63. Write a query in SQL to list the employees who are senior to their own manager. 
SELECT *
FROM employees emp, employees emp_s
WHERE emp.emp_id = emp_s.manager_id 
	AND emp.hire_date > emp_s.hire_date

-- 64. Write a query in SQL to list the employee with their grade for the grade 4.  
SELECT *
FROM employees emp, salary_grade s
WHERE emp.salary BETWEEN s.min_sal AND s.max_sal
	AND s.grade = 4
	
-- 65. Write a query in SQL to list the employees in department PRODUCTION or AUDIT who joined after 1991 and they are not MARKER or ADELYN to their name. 
SELECT *
FROM employees emp, salary_grade s, department d
WHERE d.dep_name IN('PRODUCTION', 'AUDIT')
	AND DATE_PART('year', emp.hire_date) > 1991
	AND emp.emp_name NOT IN('MARKER','ADELYN')
	AND emp.salary BETWEEN s.min_sal AND S.max_sal
	AND emp.dep_id = d.dep_id 

-- 66. Write a query in SQL to list the employees in the ascending order of their salaries. 
SELECT *
FROM employees
ORDER BY salary  

-- 67. Write a query in SQL to list the details of the employees in ascending order to the department_id and descending order to the jobs.
SELECT *
FROM employees
ORDER BY dep_id, job_name DESC

-- 68. Write a query in SQL to display all the unique job in descending order.  
SELECT DISTINCT *
FROM employees
ORDER BY job_name DESC

-- 69. Write a query in SQL to list the id, name, monthly salary, daily salary of all the employees in the ascending order of their annual salary.  
SELECT *, 
		ROUND(salary/30::numeric, 2) AS "Daily Salary", 
		ROUND(salary*12::numeric, 2) AS "Annual salary"
FROM employees
ORDER BY salary*12 

-- 70. Write a query in SQL to list the employees in descending order who are either 'CLERK' or 'ANALYST'. 
SELECT *
FROM employees
WHERE job_name IN('CLERK','ANALYST')
ORDER BY job_name DESC

-- 71. Write a query in SQL to display the location of CLARE. 
SELECT *
FROM employees e
LEFT JOIN department d ON e.dep_id = d.dep_id
WHERE emp_name = 'CLARE'

-- 72. Write a query in SQL to list the employees in ascending order of seniority who joined on 1-MAY-91,or 3-DEC-91, or 19-JAN-90.  
SELECT *
FROM employees e
WHERE hire_date IN('1991.05.01'::date, '1991.03.19'::date, '1991.12.03'::date)
ORDER BY age(CURRENT_DATE, hire_date)

-- 73. Write a query in SQL to list the employees who are drawing the salary less than 1000 and sort the output in ascending order on salary.  
SELECT *
FROM employees e
WHERE salary < 1000
ORDER BY salary 

-- 74. Write a query in SQL to list the details of the employees in ascending order on the salary. 
SELECT *
FROM employees e
ORDER BY salary

-- 75. Write a query in SQL to list the employees in ascending order on job name and descending order on employee id. 
SELECT *
FROM employees e
ORDER BY job_name, emp_id DESC

-- 76. Write a query in SQL to list the unique jobs of department 2001 and 3001 in descending order. 
SELECT *
FROM employees e
WHERE dep_id IN(2001, 3001)
ORDER BY job_name, emp_id DESC

-- 77. Write a query in SQL to list all the employees except PRESIDENT and MANAGER in ascending order of salaries.
SELECT *
FROM employees e
WHERE job_name NOT IN('PRESIDENT', 'MANAGER')
ORDER BY salary

-- 78. Write a query in SQL to list the employees in ascending order of the salary whose annual salary is below 25000.  
SELECT *
FROM employees e
WHERE salary * 12 < 25000	
ORDER BY salary

-- 79. Write a query in SQL to list the employee id, name, annual salary, daily salary of all the employees in the ascending order of annual salary who works as a SALESMAN. 
SELECT *, 
		salary/30 AS 'Daily Salary', 
		salary*12 AS 'Annual Salary'
FROM employees e
WHERE job_name = 'SALESMAN'
ORDER BY salary*12

-- 80. Write a query in SQL to list the employee id, name, hire_date, current date and experience of the employees in ascending order on their experiences.  
SELECT emp_id, emp_name, hire_date, CURRENT_DATE, age(CURRENT_DATE, hire_date) AS "Experience"
FROM employees
ORDER BY "Experience"

-- 81. Write a query in SQL to list the employees in ascending order of designations of those, joined after the second half of 1991.
SELECT *
FROM employees
WHERE DATE_PART('year', hire_date) = 1991 AND DATE_PART('month', hire_date) > 6
ORDER BY job_name

-- 82. Write a query in SQL to list the total information of employees table along with department, 
	-- and location of all the employees working under FINANCE and AUDIT in the ascending department no. 	
SELECT *
FROM employees e, department d
WHERE e.dep_id = d.dep_id 
	AND d.dep_name IN('FINANCE', 'AUDIT')
ORDER BY dep_id 

-- 83. Write a query in SQL to display the total information of the employees along with grades in ascending order.  
SELECT *, s.grade
FROM employees e, salary_grade s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal
ORDER BY s.grade

-- 84. Write a query in SQL to list the name, job name, department, salary, and grade of the employees according to the department in ascending order.
SELECT *
FROM employees e, salary_grade s, department d
WHERE e.dep_id = d.dep_id 
	AND e.salary BETWEEN s.min_sal AND s.max_sal
ORDER BY dep_id 

-- 85. Write a query in SQL to list the name, job name, salary, grade and department name of employees except CLERK and sort result set on the basis of highest salary. 
SELECT *
FROM employees e, salary_grade s, department d
WHERE e.dep_id = d.dep_id 
	AND e.salary BETWEEN s.min_sal AND s.max_sal
	AND e.job_name <> 'CLERK'
ORDER BY e.salary DESC

-- 86. Write a query in SQL to list the employee ID, name, salary, department, grade, experience, and annual salary of employees working for department 1001 or 2001.
SELECT *, 
		e.salary*12 AS "Annual Salary",
		age(CURRENT_DATE, hire_date) AS "Experience"
FROM employees e, salary_grade s, department d
WHERE e.dep_id = d.dep_id 
	AND e.salary BETWEEN s.min_sal AND s.max_sal
	AND e.dep_id IN(1001,2001)

-- 87. Write a query in SQL to list the details of the employees along with the details of their departments. 
SELECT *
FROM employees e, department d
WHERE e.dep_id = d.dep_id 

-- 88. Write a query in SQL to list the employees who are senior to their own MANAGERS. 
SELECT *
FROM employees e, employees m
WHERE e.hire_date > m.hire_date
	AND e.emp_id = m.manager_id

-- 89. Write a query in SQL to list the employee id, name, salary, and department id of the employees in ascending order of salary who works in the department 1001.
SELECT *
FROM employees 
WHERE dep_id = 1001
ORDER BY salary

-- 90. Write a query in SQL to find the highest salary from all the employees. 
SELECT MAX(salary)
FROM employees 

-- 91. Write a query in SQL to find the average salary and average total remuneration(salary and commission) for each type of job. 
SELECT job_name, AVG(salary) AS "average", AVG(salary + commission) AS "average total remuneration"
FROM employees 
GROUP BY job_name

-- 92. Write a query in SQL to find the total annual salary distributed against each job in the year 1991.
SELECT job_name, SUM(salary*12)
FROM employees 
WHERE DATE_PART('year', hire_date) = 1991
GROUP BY job_name

-- 93. Write a query in SQL to list the employee id, name, department id, location of all the employees. 
SELECT *
FROM employees e, department d
WHERE e.dep_id = d.dep_id

-- 94. Write a query in SQL to list the employee id, name, location, department of all the departments 1001 and 2001. 
SELECT *
FROM employees e, department d
WHERE e.dep_id = d.dep_id
	AND e.dep_id IN(1001,2001)

-- 95. Write a query in SQL to list the employee id, name, salary, grade of all the employees.
SELECT *
FROM employees e, salary_grade s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal
	
-- 96. Write a query in SQL to list the manager no and the number of employees working for those managers in ascending order on manager id.
SELECT manager_id, COUNT(emp_id)
FROM employees
GROUP BY manager_id
ORDER BY manager_id

-- 97. Write a query in SQL to display the number of employee for each job in each department.
SELECT job_name, dep_id, COUNT(*)
FROM employees
GROUP BY job_name, dep_id

-- 98. Write a query in SQL to list the department where at least two employees are working.  
SELECT dep_id, COUNT(*)
FROM employees
GROUP BY dep_id
HAVING COUNT(*) >= 2

-- 99. Write a query in SQL to display the Grade, Number of employees, and maximum salary of each grade.
SELECT grade, COUNT(*)
FROM employees e, salary_grade s
GROUP BY dep_id
HAVING COUNT(*) >= 2

-- 100. Write a query in SQL to display the department name, grade, no. of employees where at least two employees are working as a SALESMAN
SELECT d.dep_name, s.grade, COUNT(*)
FROM employees e, salary_grade s, department d
WHERE e.dep_id = d.dep_id
	AND e.job_name = 'SALESMAN'
	AND e.salary BETWEEN s.min_sal AND s.max_sal
GROUP BY d.dep_name, s.grade
HAVING COUNT(*) >= 2

-- 101. Write a query in SQL to list the no. of employees in each department where the no. is less than 4. 
SELECT dep_id, COUNT(*)
FROM employees e
GROUP BY dep_id
HAVING COUNT(*) < 4

-- 102. Write a query in SQL to list the name of departments where atleast 2 employees are working in that department.
SELECT dep_name, COUNT(*)
FROM employees e, department d
WHERE e.dep_id = d.dep_id
GROUP BY dep_name  
HAVING COUNT(*) >= 2

-- 103. Write a query in SQL to check whether all the employees numbers are indeed unique.
SELECT emp_id, COUNT(*)
FROM employees
GROUP BY emp_id  

-- 104. Write a query in SQL to list the no. of employees and average salary within each department for each job name. 
SELECT job_name, dep_id, AVG(salary), COUNT(*)
FROM employees
GROUP BY job_name, dep_id 

--- LIKE OPERATOR LOGIC

-- 'x%' -> EVERYTHING BEFORE % sign matters 
-- '%x' -> EVERYTHING AFTER % sign matters 

-----

-- 105. Write a query in SQL to list the names of those employees starting with 'A' and with six characters in length. 
SELECT *
FROM employees
WHERE emp_name LIKE 'A_____%'

SELECT *
FROM employees
WHERE emp_name LIKE 'A%' AND LENGTH(emp_name) = 6

-- 106. Write a query in SQL to list the employees whose name is six characters in length and third character must be 'R'. 
SELECT *
FROM employees
WHERE emp_name LIKE '__R___%'

SELECT *
FROM employees
WHERE emp_name LIKE '__R%' AND LENGTH(emp_name) = 6

-- 107. Write a query in SQL to list the name of the employee of six characters long and starting with 'A' and ending with 'N'.  
SELECT *
FROM employees
WHERE emp_name LIKE 'A____N%'

SELECT *
FROM employees
WHERE emp_name LIKE 'A%N' 
	AND LENGTH(emp_name) = 6
	
-- 108. Write a query in SQL to list the employees who joined in the month of which second character is 'a'.  
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, 'month') LIKE '_a%'
	
-- 109. Write a query in SQL to list the employees whose names containing the character set 'AR' together. 
SELECT *
FROM employees
WHERE emp_name LIKE '%AR%' 

-- 110. Write a query in SQL to list the employees those who joined in 90's.  
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') LIKE '199_%'

-- 111. Write a query in SQL to list the employees whose ID not starting with digit 68. 
SELECT *
FROM employees
WHERE emp_id::text NOT LIKE '68%'

-- 112. Write a query in SQL to list the employees whose names containing the letter 'A'.
SELECT *
FROM employees
WHERE emp_name LIKE '%A%' 

-- 113. Write a query in SQL to list the employees whose name is ending with 'S' and six characters long. 
SELECT *
FROM employees
WHERE emp_name LIKE '%S' AND LENGTH(emp_name) = 6

-- 114. Write a query in SQL to list the employees who joined in the month having char 'A' at any position. 
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, 'month') LIKE '%A%'

-- 115. Write a query in SQL to list the employees who joined in the month having second char is 'A'.
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, 'month') LIKE '_A%'
