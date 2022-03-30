DECLARE	
v_count NUMBER := 0;

CURSOR c_course_cursor IS 
	SELECT description 
	FROM course 
	WHERE prerequisite IS NULL;

BEGIN
FOR i IN c_course_cursor
LOOP
v_count := v_count + 1;
DBMS_OUTPUT.PUT_LINE('Course Description : ' || v_count || ': ' || i.description);
END LOOP;
DBMS_OUTPUT.PUT_LINE('************************************');
DBMS_OUTPUT.PUT_LINE('Total # of Courses without the Prerequisite is: ' || v_count);
END;
/