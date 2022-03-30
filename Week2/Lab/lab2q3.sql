ACCEPT positive_integer PROMPT 'Please enter a Positive Integer: '
DECLARE
	num INT :=&positive_integer;
	total NUMBER := 0;
BEGIN
	FOR i IN 1..num LOOP
		IF MOD(num,2) = 1 THEN
			IF MOD(i,2) = 1 THEN
				total := total + i;
			END IF;
		ELSE
			IF MOD(i,2) = 0 THEN
				total := total + i;
			END IF;
		END IF;
	END LOOP;
	IF MOD(num,2) = 0 THEN
		DBMS_OUTPUT.PUT_LINE('The sum of Even integers between 1 and ' || num || ' is ' || total);
	ELSE
		DBMS_OUTPUT.PUT_LINE('The sum of Odd integers between 1 and ' || num || ' is ' || total);
	END IF;
END;
/