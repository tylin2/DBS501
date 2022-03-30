CREATE OR REPLACE PROCEDURE modify_sal(
	v_dep_id employees.department_id%TYPE
) 
IS
	v_avg employees.salary%TYPE;	
	v_less employees.salary%TYPE;
	v_count NUMBER := 0;
	v_rows NUMBER;
	CURSOR c1
	IS
		SELECT e.salary, e.first_name, e.last_name, e.employee_id
		FROM employees e
		RIGHT JOIN departments d ON e.department_id = d.department_id
		WHERE d.department_id = v_dep_id;
	unfound EXCEPTION;  
BEGIN
	SELECT COUNT(*) INTO v_rows
	FROM employees e
	RIGHT JOIN departments d ON e.department_id = d.department_id
	WHERE d.department_id = v_dep_id;
	IF v_rows > 0 THEN
		SELECT AVG(e.salary) INTO v_avg
		FROM employees e
		RIGHT JOIN departments d ON e.department_id = d.department_id
		WHERE d.department_id = v_dep_id;
		IF v_avg > 0 THEN
			FOR i IN c1 LOOP
				EXIT  WHEN  c1%NOTFOUND;
				IF i.salary < v_avg THEN
					v_less := v_avg - i.salary;
					UPDATE employees
					SET salary = v_avg
					WHERE employee_id = i.employee_id;
					DBMS_OUTPUT.PUT_LINE('Employee ' || i.first_name ||' ' || i.last_name ||' just got an increase of $' || v_less);
					v_count := v_count + 1;
				END IF;
			END LOOP;
			IF v_count = 0 THEN
				DBMS_OUTPUT.PUT_LINE('No salary was modified in Department: ' || v_dep_id);
			ELSE
				DBMS_OUTPUT.PUT_LINE('Total # of employees who received salary increase is: ' || v_count);
			END IF;			
		ELSE
			DBMS_OUTPUT.PUT_LINE('This Department is EMPTY: ' || v_dep_id);
		END IF;
	ELSE
		RAISE unfound;   
	END IF;	
EXCEPTION
	WHEN unfound THEN
		DBMS_OUTPUT.PUT_LINE('This Department Id is invalid: ' || v_dep_id);		
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('There are some other errors. ');
END modify_sal;
/
SHOW ERRORS;

