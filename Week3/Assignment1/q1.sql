ACCEPT country PROMPT 'Enter value for country: '
VARIABLE b_locid NUMBER
DECLARE
	i_country locations.country_id%TYPE := '&country';
	v_city locations.city%TYPE;
	v_sp locations.state_province%TYPE;	
BEGIN	
		SELECT city, location_id INTO v_city, :b_locid
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
EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('This country has NO cities listed.');
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE('This country has MORE THAN ONE City without province listed.');
END;
/

SELECT location_id, street_address, postal_code, city, state_province, country_id
FROM locations
WHERE location_id IN :b_locid;

ROLLBACK;

/*
Output:

SQL> @q1
Enter value for country: JP
City Hiroshima has modified its province to &&&&&&&&&&&&&&&

PL/SQL procedure successfully completed.


LOCATION_ID STREET_ADDRESS                           POSTAL_CODE
----------- ---------------------------------------- ------------
CITY                           STATE_PROVINCE            CO
------------------------------ ------------------------- --
       1300 9450 Kamiya-cho                          6823
Hiroshima                      &&&&&&&&&&&&&&&           JP



Rollback complete.

SQL> @q1
Enter value for country: UK
City London has modified its province to ##############

PL/SQL procedure successfully completed.


LOCATION_ID STREET_ADDRESS                           POSTAL_CODE
----------- ---------------------------------------- ------------
CITY                           STATE_PROVINCE            CO
------------------------------ ------------------------- --
       2400 8204 Arthur St
London                         ##############            UK



Rollback complete.

SQL> @q1
Enter value for country: IT
This country has MORE THAN ONE City without province listed.

PL/SQL procedure successfully completed.


no rows selected


Rollback complete.

SQL> @q1
Enter value for country: RS
This country has NO cities listed.

PL/SQL procedure successfully completed.


no rows selected


Rollback complete.

*/
