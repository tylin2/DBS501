ACCEPT zipCode PROMPT 'Input of first 3 digits for a Zip Code: '
DECLARE	
	TYPE t_rec is RECORD( 
		v_zip NUMBER,
		v_stu_num NUMBER
	);	
	t_student t_rec;
	CURSOR c_zip IS 
		Select zip, COUNT(student_id) 
		FROM (SELECT DISTINCT s.zip, s.student_id from Student s
				LEFT JOIN enrollment e
				ON s.student_id = e.student_id 
				WHERE s.zip LIKE '&zipCode' || '%')
		GROUP BY zip
		ORDER BY zip;
	v_count NUMBER := 0;
	v_stu_sum NUMBER;
BEGIN
	SELECT COUNT(*) INTO v_stu_sum 
	FROM student 
	WHERE zip LIKE '&zipCode'|| '%';
	IF(v_stu_sum > 0) THEN
		OPEN c_zip;
		LOOP
			FETCH c_zip INTO t_student;
			EXIT WHEN c_zip%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE('Zip code: ' || t_student.v_zip || ' has exactly ' || t_student.v_stu_num || ' students enrolled.');
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