ACCEPT country PROMPT 'Enter value for country: '
DECLARE
	i_country locations.country_id%TYPE := '&country';
	v_city locations.city%TYPE;
	v_sp locations.state_province%TYPE;
	v_locationID locations.location_id%TYPE;
	v_rows number := 0;
BEGIN
	BEGIN
		SELECT city, location_id INTO v_city, v_locationID
		FROM locations
		WHERE country_id = i_country AND state_province IS NULL;
		IF v_city LIKE 'A%' OR v_city LIKE 'B%' OR v_city LIKE 'E%' OR v_city LIKE 'F%' THEN
			v_sp := '***************';		
		ELSIF v_city LIKE 'C%' OR v_city LIKE 'D%' OR v_city LIKE 'G%'OR v_city LIKE 'H%' THEN			
			v_sp := '&&&&&&&&&&&&&&&';				
		ELSE
			v_sp := '##############';		
		END IF;
		UPDATE locations
		SET state_province = v_sp
		WHERE country_id = i_country AND state_province IS NULL;
		DBMS_OUTPUT.PUT_LINE('City ' || v_city ||' has modified its province to ' || v_sp );
		v_rows := SQL%ROWCOUNT;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('This country has NO cities listed.');
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE('This country has MORE THAN ONE City without province listed.');	
	END;
 	
	DECLARE
		display SYS_REFCURSOR;
	BEGIN
		IF v_rows NOT IN (0) THEN
			OPEN display for
			SELECT location_id, street_address, postal_code, city, state_province, country_id
			FROM locations
			WHERE location_id = v_locationID;
			DBMS_SQL.RETURN_RESULT(display);		
		ELSE
			DBMS_OUTPUT.PUT_LINE(CHR(10));
			DBMS_OUTPUT.PUT_LINE('no rows selected');
		END IF;		
	END;
END;
/

ROLLBACK;
