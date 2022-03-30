ACCEPT zipCode PROMPT 'Input of first 3 digits for a Zip Code: '
DECLARE	
	CURSOR c_zip IS 
		SELECT zip, COUNT(student_id) AS stu_co
		FROM (SELECT DISTINCT s.zip, s.student_id FROM Student s
				LEFT JOIN enrollment e
				ON s.student_id = e.student_id 
				WHERE s.zip LIKE '&zipCode' || '%')
		GROUP BY zip
		ORDER BY zip;
	c_stu c_zip%ROWTYPE;
	
	TYPE t_zip_table IS TABLE OF
		c_stu%TYPE INDEX BY PLS_INTEGER;
	zip_table t_zip_table;	
	v_count NUMBER := 0;
	v_stu_sum NUMBER;
BEGIN
	SELECT COUNT(*) INTO v_stu_sum 
	FROM student 
	WHERE zip LIKE '&zipCode'|| '%';
	IF(v_stu_sum > 0) THEN
		FOR i IN c_zip LOOP
			DBMS_OUTPUT.PUT_LINE('Zip code: ' || i.zip || ' has exactly ' || i.stu_co || ' students enrolled.');
			v_count := v_count + 1;
		END LOOP;		
		DBMS_OUTPUT.PUT_LINE('************************************');
		DBMS_OUTPUT.PUT_LINE('Total # of zip codes under ' || '&zipCode' || ' is ' || v_count);
		DBMS_OUTPUT.PUT_LINE('Total # of Students under zip code ' || '&zipCode' || ' is ' || v_stu_sum);
	ELSE
		DBMS_OUTPUT.PUT_LINE('This zip area is student empty. Please, try again.');
	END IF;	
END;
/