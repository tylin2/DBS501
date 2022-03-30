CREATE OR REPLACE FUNCTION Total_Cost(
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
/
SHOW ERRORS;

VARIABLE COST NUMBER

EXECUTE :COST := Total_Cost(194);
PRINT COST 

EXECUTE :COST := Total_Cost(294);
PRINT COST

EXECUTE :COST := Total_Cost(494);
PRINT COST

/*
Output:

SQL> @a2-2

Function created.

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