CREATE OR REPLACE FUNCTION instruct_status(
	v_fname instructor.first_name%TYPE,
	v_lname instructor.last_name%TYPE
) 
RETURN VARCHAR2
IS
	v_insId instructor.instructor_id%TYPE;
	v_sec NUMBER;
	v_mes VARCHAR2(200);
	v_ufname instructor.first_name%TYPE := INITCAP(v_fname);
	v_ulname instructor.first_name%TYPE := INITCAP(v_lname);
BEGIN
	SELECT instructor_id INTO v_insId 
	FROM instructor
	WHERE first_name = v_ufname AND last_name = v_ulname;
	
	SELECT COUNT(*) INTO v_sec
	FROM section
	WHERE instructor_id = v_insId;
	
	IF (v_sec > 9) THEN
		v_mes := 'This Instructor will teach ' || v_sec || ' course and needs a vacation';
	ELSIF (v_sec > 0 AND v_sec <= 9) THEN
		v_mes := 'This Instructor will teach ' || v_sec || ' courses.';
	ELSE
		v_mes := 'This Instructor is NOT scheduled to teach';	
	END IF;	
	RETURN v_mes;	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		v_mes := 'There is NO such instructor.'; 
		RETURN v_mes;
	WHEN OTHERS THEN
		v_mes := 'There are something other errors.';
		RETURN v_mes;
END instruct_status;
/


VARIABLE MESSAGE VARCHAR2(200)

SELECT LAST_NAME, instruct_status(first_name, last_name) "Instructor Status"
FROM instructor
ORDER BY last_name;

EXECUTE :MESSAGE := instruct_status('PETER', 'PAN');
PRINT MESSAGE 

EXECUTE :MESSAGE  := instruct_status('IRENE', 'WILLIG');
PRINT MESSAGE 