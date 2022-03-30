    ACCEPT scale CHAR PROMPT 'Enter your input scale (C or F) for temperature: '
	ACCEPT temp NUMBER PROMPT 'Enter your temperature value to be converted:  '
DECLARE
	input_scale CHAR;
	input_temp NUMBER;
	new_temp NUMBER(4,1);
BEGIN
	input_scale  := '&scale';
	input_temp := &temp;	
	IF input_scale = 'C' THEN
		new_temp := ((9*input_temp) / 5) + 32;
		DBMS_OUTPUT.PUT_LINE('Your converted temperature in F is exactly ' || new_temp);
	ELSIF input_scale = 'F' THEN
		new_temp := ((input_temp - 32)*5) / 9;
		DBMS_OUTPUT.PUT_LINE('Your converted temperature in C is exactly ' || new_temp);
	ELSE
		DBMS_OUTPUT.PUT_LINE('The scale you input is not a valid scale');
	END IF;
END;
/