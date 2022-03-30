ACCEPT search_Id PROMPT 'Please enter the Instructor Id: '
DECLARE
	ins_Id NUMBER := &search_Id;
	num_sections NUMBER;
	lname VARCHAR2(25);
	fname VARCHAR2(25);
BEGIN	
	SELECT COUNT(s.instructor_id), i.first_name, i.last_name INTO num_sections, fname, lname
	FROM instructor i
	LEFT JOIN section s ON s.instructor_id = i.instructor_id
	WHERE i.instructor_id = ins_Id
	GROUP BY s.instructor_id, i.first_name, i.last_name;	
	DBMS_OUTPUT.PUT_LINE('Instructor, ' || fname || ' ' || lname || ', teaches ' || num_sections || ' section(s).');
	IF num_sections >= 10 THEN
		DBMS_OUTPUT.PUT_LINE('This instructor needs to rest in the next term. ');
	ELSIF num_sections <= 3 THEN
		DBMS_OUTPUT.PUT_LINE('This instructor may teach more sections.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('This instructor teaches enough sections. ');
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('This is not a valid instructor');
END;
/