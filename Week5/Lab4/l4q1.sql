CREATE OR REPLACE PROCEDURE mine(
p_date VARCHAR2,
p_case CHAR
) IS
v_upper CHAR := UPPER(p_case);
v_count NUMBER;
e_invalid EXCEPTION;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Last day of the month ' || p_date || ' is ' || TO_CHAR(LAST_DAY(TO_DATE(p_date,'MM/YY')),'Day'));	
	
	IF (v_upper NOT LIKE 'P' AND v_upper NOT LIKE 'F' and v_upper NOT LIKE 'B') THEN 
		RAISE e_invalid;		
	ELSIF (v_upper = 'P') THEN
		SELECT COUNT(*) INTO v_count FROM user_objects
			WHERE object_type = 'PROCEDURE';	
	ELSIF (v_upper = 'F') THEN
		SELECT COUNT(*) INTO v_count FROM user_objects
			WHERE object_type = 'FUNCTION';
	ELSIF (v_upper = 'B') THEN
		SELECT COUNT(*) INTO v_count FROM user_objects
			WHERE object_type = 'PACKAGE';		
	END IF;	
	DBMS_OUTPUT.PUT_LINE('Number of stored objects of type ' || v_upper || ' is ' || v_count);
EXCEPTION
	WHEN e_invalid THEN
		DBMS_OUTPUT.PUT_LINE('You have entered an Invalid letter for the stored object. Try P, F or B. ');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('You have entered an Invalid FORMAT for the MONTH and YEAR. Try MM/YY.');	
END mine;
/

 EXECUTE MINE('11/09','P');
 EXECUTE MINE('12/09','f');
 EXECUTE MINE('01/10','T');
 EXECUTE MINE('13/09','P');	