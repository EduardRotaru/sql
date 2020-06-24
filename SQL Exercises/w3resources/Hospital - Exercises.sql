-----------------------------------------------------  HOSPITAL DATABASE ------------------------------------------------

-- 1. Write a query in SQL to find all the information of the nurses who are yet to be registered.
SELECT *
FROM nurse
WHERE registered = 'f'

-- 2. Write a query in SQL to find the name of the nurse who are the head of their department. 
SELECT *
FROM nurse
WHERE position = 'Head Nurse'

-- 3. Write a query in SQL to obtain the name of the physicians who are the head of each department. 
SELECT name
FROM physician p
INNER JOIN department d ON d.head = p.employeeid 

-- 4. Write a query in SQL to count the number of patients who taken appointment with at least one physician. 
SELECT COUNT(*)
FROM appointment
WHERE physician >= 1

-- 5. Write a query in SQL to find the floor and block where the room number 212 belongs to. 
SELECT *
FROM room
WHERE roomnumber = 212

-- 6. Write a query in SQL to count the number available rooms.
SELECT *
FROM room
WHERE unavailable = 'f'

-- 7. Write a query in SQL to count the number of unavailable rooms.
SELECT COUNT(*)
FROM room
WHERE unavailable = 't'

-- 8. Write a query in SQL to obtain the name of the physician and the departments they are affiliated with.
SELECT p.name, d.name
FROM physician p, department d, affiliated_with a
WHERE d.departmentid = a.departmentid 
	AND a.physician = p.employeeid 

-- 9. Write a query in SQL to obtain the name of the physicians who are trained for a special treatement. 
SELECT p.name, pr.name
FROM physician p, procedure pr, trained_in t
WHERE pr.code = t.treatment 
	AND p.employeeid = t.physician 

-- 10. Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated.
SELECT p.name, p.position, d.name     
FROM physician p, affiliated_with a, department d
WHERE p.employeeid = a.physician 
	AND a.department = d.departmentid 
	AND primaryaffiliation = 'f'

-- 11. Write a query in SQL to obtain the name of the physicians who are not a specialized physician.
SELECT DISTINCT p.name, p.position
FROM physician p
LEFT JOIN trained_in t ON p.employeeid = t.physician 
WHERE t.treatment IS NULL

-- 12. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement.
SELECT pa.name, ph.name        
FROM patient pa
LEFT JOIN physician ph ON pa.pcp = ph.employeeid 

-- 13. Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment.
SELECT COUNT(pa.patient), ph.name      
FROM appointment pa
LEFT JOIN patient ph ON pa.patient = ph.ssn 
GROUP BY ph.name
HAVING COUNT(pa.patient) > 0

-- 14. Write a query in SQL to count number of unique patients who got an appointment for examination room C.
SELECT DISTINCT *
FROM appointment
WHERE examinationroom = 'C'

-- 15. Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment.
SELECT p.name, a.examinationroom
FROM patient p
INNER JOIN appointment a ON p.pcp = a.physician 

-- 16. Write a query in SQL to find the name of the nurses and the room scheduled, where they will assist the physicians.
SELECT n.name, a.examinationroom
FROM nurse n
INNER JOIN appointment a ON n.employeeid = a.prepnurse 

-- 17. Write a query in SQL 
	-- to find the name of the patients who taken the appointment on the 25th of April at 10 am, and also display their physician, assisting nurses and room no. 
SELECT p.name
FROM patient p
INNER JOIN appointment a ON p.ssn = a.patient  
INNER JOIN nurse n ON a.prepnurse = n.employeeid 
INNER JOIN physician ph ON a.physician  = ph.employeeid 
WHERE a.start_dt_time = '2008.04.25 10:00:00'

-- 18. Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse. 
SELECT p.name, m.name
FROM patient p
INNER JOIN prescribes pr ON p.ssn = pr.patient  
INNER JOIN physician ph ON p.pcp = ph.employeeid  
INNER JOIN medication m ON pr.medication = m.code  
WHERE m.description = 'N/A'

-- 19. Write a query in SQL to find the name of the patients, their treating physicians and medication. 
SELECT p.name, ph.name, m.name
FROM patient p
INNER JOIN prescribes pr ON p.ssn = pr.patient  
INNER JOIN physician ph ON pr.physician = ph.employeeid  
INNER JOIN medication m ON pr.medication = m.code  

-- 20. Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their physicians and medication.  
SELECT p.name, ph.name, m.name
FROM patient p
INNER JOIN prescribes pr ON p.ssn = pr.patient  
INNER JOIN physician ph ON pr.physician = ph.employeeid  
INNER JOIN medication m ON pr.medication = m.code  
WHERE pr.appointment IS NOT NULL

-- 21. Write a query in SQL to find the name and medication for those patients who did not take any appointment. 
SELECT p.name, ph.name, m.name
FROM patient p
INNER JOIN prescribes pr ON p.ssn = pr.patient  
INNER JOIN physician ph ON pr.physician = ph.employeeid  
INNER JOIN medication m ON pr.medication = m.code  
WHERE pr.appointment IS NULL

-- 22. Write a query in SQL to count the number of available rooms in each block. 
SELECT COUNT(*), blockcode 
FROM room r
GROUP BY blockcode, unavailable
HAVING unavailable = 'f'

-- 23. Write a query in SQL to count the number of available rooms in each floor.
SELECT COUNT(*), blockfloor  
FROM room r
GROUP BY blockfloor, unavailable
HAVING unavailable = 'f'
ORDER BY blockfloor

-- 24. Write a query in SQL to count the number of available rooms for each block in each floor. 
SELECT COUNT(*) "Room Available", blockfloor, blockcode 
FROM room r
GROUP BY blockfloor, blockcode, unavailable
HAVING unavailable = 'f'
ORDER BY blockfloor, blockcode

-- 25. Write a query in SQL to count the number of unavailable rooms for each block in each floor. 
SELECT COUNT(*) "Room Available", blockfloor, blockcode 
FROM room r
GROUP BY blockfloor, blockcode, unavailable
HAVING unavailable = 't'
ORDER BY blockfloor, blockcode

-- 26. Write a query in SQL to find out the floor where the maximum no of rooms are available. 
SELECT COUNT(blockfloor) MaximumRooms, blockfloor
FROM room r
WHERE unavailable = 'f'
GROUP BY blockfloor
ORDER BY COUNT(blockfloor) DESC

-- 27. Write a query in SQL to find out the floor where the minimum no of rooms are available. 
SELECT COUNT(blockfloor) MaximumRooms, blockfloor
FROM room r
WHERE unavailable = 'f'
GROUP BY blockfloor
ORDER BY COUNT(blockfloor) ASC

-- 28. Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted. 
SELECT s.patient, p.name, r.roomnumber        
FROM stay s
INNER JOIN patient p ON s.patient = p.ssn    
INNER JOIN room r ON s.room = r.roomnumber 

-- 29. Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call. 
SELECT n.name, o.blockcode 
FROM nurse n
INNER JOIN on_call o ON n.employeeid = o.nurse 

-- 30. Write a query in SQL to make a report which will show -
-- 		a) name of the patient,
-- 		b) name of the physician who is treating him or her,
-- 		c) name of the nurse who is attending him or her,
-- 		d) which treatement is going on to the patient,
-- 		e) the date of release,
-- 		f) in which room the patient has admitted and which floor and block the room belongs to respectively. 

SELECT p.name, ph.name, n.name, s.end_time, u.procedure, r.roomnumber, r.blockfloor, r.blockcode 
FROM undergoes u
INNER JOIN patient p ON u.patient = p.ssn    
INNER JOIN physician ph ON u.physician = ph.employeeid
INNER JOIN nurse n ON u.assistingnurse = n.employeeid
INNER JOIN stay s ON u.stay = s.stayid  
INNER JOIN room r ON s.room = r.roomnumber 

-- 31. Write a SQL query to obtain the names of all the physicians performed a medical procedure but they are not ceritifed to perform.
SELECT ph.name
FROM undergoes u
INNER JOIN trained_in t ON u.physician = t.physician     
INNER JOIN physician ph ON u.physician = ph.employeeid
WHERE t.certificationexpires < u.date         

-- 32. Write a query in SQL to obtain the names of all the physicians, their procedure, date when the procedure was carried out 
	-- and name of the patient on which procedure have been carried out but those physicians are not cetified for that procedure. 
SELECT ph.name, p.name, pa.name, u.date                     
FROM undergoes u
INNER JOIN physician ph ON u.physician = ph.employeeid
INNER JOIN procedure p ON u.procedure = p.code      
INNER JOIN patient pa ON u.patient = pa.ssn 
INNER JOIN trained_in t ON t.treatment = u.procedure 
WHERE t.certificationexpires < u.date 

-- 33. Write a query in SQL to obtain the name and position of all physicians 
	-- who completed a medical procedure with certification after the date of expiration of their certificate. 
SELECT ph.name, ph.position           
FROM undergoes u
INNER JOIN trained_in t ON u.physician = t.physician 
	AND t.treatment = u.procedure     
INNER JOIN physician ph ON u.physician = ph.employeeid
WHERE t.certificationexpires < u.date         

-- 34. Write a query in SQL to obtain the name of all those physicians who completed a medical procedure with certification after the date of expiration of their certificate, 
	-- their position, procedure they have done, date of procedure, name of the patient on which the procedure had been applied and the date when the certification expired. 
SELECT ph.name, p.name, ph.position, pa.name, t.certificationexpires                  
FROM undergoes u
INNER JOIN physician ph ON u.physician = ph.employeeid
INNER JOIN procedure p ON u.procedure = p.code      
INNER JOIN patient pa ON u.patient = pa.ssn 
INNER JOIN trained_in t ON t.treatment = u.procedure 
		AND t.treatment = u.procedure  
WHERE t.certificationexpires < u.date 

-- 35. Write a query in SQL to obtain the names of all the nurses who have ever been on call for room 122.  
SELECT n.name                     
FROM nurse n
INNER JOIN on_call o ON n.employeeid = o.nurse 
INNER JOIN room r ON o.blockfloor = r.blockfloor 
	AND o.blockcode = r.blockcode 
WHERE r.roomnumber = 122

-- 36. Write a query in SQL to Obtain the names of all patients who 
	-- has been prescribed some medication by his/her physician 
		-- who has carried out primary care and the name of that physician.  
SELECT p.name, ph.name                 
FROM patient p
INNER JOIN prescribes pr ON p.ssn = pr.patient   
INNER JOIN physician ph ON ph.employeeid = pr.physician  
WHERE p.pcp = pr.physician 

-- 37. Write a query in SQL to obtain the names of all patients who 
	-- has been undergone a procedure costing more than $5,000 and the name of that physician who has carried out primary care. 
SELECT p.name, ph.name                 
FROM patient p
INNER JOIN undergoes u ON p.ssn = u.patient   
INNER JOIN physician ph ON ph.employeeid = u.physician  
INNER JOIN procedure pr ON u.procedure  = pr.code  
WHERE pr.cost > 5000
	AND p.pcp = ph.employeeid  

-- 38. Write a query in SQL to Obtain the names of all patients who had at least two appointment where the nurse 
	-- who prepped the appointment was a registered nurse and the physician who has carried out primary care. 
SELECT p.name, ph.name, n.name               
FROM patient p
INNER JOIN appointment a ON p.ssn = a.patient     
LEFT JOIN nurse n ON n.employeeid = a.prepnurse   
INNER JOIN physician ph ON ph.employeeid = a.physician 
	AND p.pcp = ph.employeeid  
WHERE n.registered = 't'
GROUP BY p.name, ph.name, n.name     
HAVING COUNT(a.*) > 1

-- 39. Write a query in SQL to Obtain the names of all patients whose primary care is taken by a physician
	-- who is not the head of any department and name of that physician along with their primary care physician.  
SELECT p.name, ph.name             
FROM patient p
INNER JOIN physician ph ON ph.employeeid = p.pcp  
WHERE p.pcp NOT IN(SELECT HEAD
				  FROM department)