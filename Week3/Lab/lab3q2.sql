DECLARE	
	TYPE t_course_table IS TABLE OF
		course.description%TYPE INDEX BY PLS_INTEGER;
	course_table t_course_table;
	v_count NUMBER := 0;
	CURSOR c_course_cursor IS 
		SELECT description 
		FROM course 
		WHERE prerequisite IS NULL;
BEGIN
	OPEN c_course_cursor;
	FETCH c_course_cursor BULK COLLECT INTO course_table;
	CLOSE c_course_cursor;
	FOR i IN 1..course_table.COUNT
	LOOP
		--course_table.EXTEND;
		v_count := i;
		DBMS_OUTPUT.PUT_LINE('Course Description : ' || v_count || ': ' || course_table(i));
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('************************************');
	DBMS_OUTPUT.PUT_LINE('Total # of Courses without the Prerequisite is: ' || v_count);
END;
/