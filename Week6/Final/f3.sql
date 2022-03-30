CREATE OR REPLACE TRIGGER Remove_Emp_Trig
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
	IF (SUBSTR(:OLD.job_id,1,2) <> 'SA') THEN
		IF TO_CHAR(SYSDATE,'D') NOT IN ('1', '7') OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN '8' AND '17') THEN 
			RAISE_APPLICATION_ERROR(-20500, 'You may DELETE EMPLOYEES table only during normal business hours.');
		END IF;	
	END IF;
END;
/

SHOW ERRORS;

--test for jpb_id: AD%
DELETE FROM employees
WHERE employee_id = 100;

--test for jpb_id: SA% 
DELETE FROM employees
WHERE employee_id = 169; 
ROLLBACK;