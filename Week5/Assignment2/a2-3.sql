CREATE OR REPLACE PACKAGE My_pack 
IS
PROCEDURE modify_sal(v_dep_id employees.department_id%TYPE); 
FUNCTION Total_Cost(v_st_ID student.student_id%TYPE) 
RETURN NUMBER;
END My_pack;
/

CREATE OR REPLACE PACKAGE BODY My_pack 
IS

PROCEDURE modify_sal(
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

FUNCTION Total_Cost(
	v_st_ID student.student_id%TYPE	
) 
RETURN NUMBER
IS	
	v_count NUMBER;
	v_cost NUMBER;
BEGIN
	SELECT COUNT(*), NVL(SUM(c.cost),0) INTO v_count, v_cost
	FROM student s
	LEFT JOIN enrollment e ON s.student_id = e.student_id
	LEFT JOIN section se ON e.section_id = se.section_id
	LEFT JOIN course c ON se.course_no = c.course_no
	WHERE s.student_id = v_st_ID;	
	
	IF v_count = 0 THEN
		v_cost := -1;
	END IF;
	
	RETURN v_cost;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		v_cost := -1; 
		RETURN v_cost;
END Total_Cost;

END My_pack;
/
SHOW ERRORS;

VARIABLE COST NUMBER

EXECUTE :COST := My_pack.Total_Cost(194);
PRINT COST 

EXECUTE :COST := My_pack.Total_Cost(294);
PRINT COST

EXECUTE :COST := My_pack.Total_Cost(494);
PRINT COST

/*
Output:

SQL> @a2-3;

Package created.


Package body created.

No errors.

PL/SQL procedure successfully completed.


      COST
----------
      1195


PL/SQL procedure successfully completed.


      COST
----------
         0


PL/SQL procedure successfully completed.


      COST
----------
        -1

*/