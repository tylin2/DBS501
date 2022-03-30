CREATE OR REPLACE FUNCTION exist_zip(
	v_zip zipcode.zip%TYPE
 ) 
RETURN BOOLEAN
IS
	v_input NUMBER;
BEGIN
	SELECT COUNT(*) INTO v_input 
	FROM zipcode
	WHERE zip = v_zip;
	
	IF v_input > 0 THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;	
	END IF;

EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
END exist_zip;
/


CREATE OR REPLACE PROCEDURE add_zip2(
  p_zip zipcode.zip%TYPE,
  p_city zipcode.city%TYPE,
  p_state zipcode.state%TYPE,
  p_flag OUT VARCHAR2,
  p_zipnum OUT NUMBER
 )
IS
  v_zip zipcode.zip%TYPE;
  unfound EXCEPTION;  
BEGIN
  IF exist_zip(p_zip) THEN
    p_flag := 'FAILURE';
  ELSE
    RAISE unfound;   
  END IF; 
  
  DBMS_OUTPUT.PUT_LINE('This ZIPCODE ' || p_zip ||' is already in the Dataase. Try again.');
  SELECT COUNT(*) INTO p_zipnum 
  FROM zipcode 
  WHERE state = p_state;
EXCEPTION
  WHEN unfound THEN
    p_flag := 'SUCCESS';
    INSERT INTO zipcode
	VALUES (p_zip, p_city, p_state, USER, SYSDATE, USER, SYSDATE);
	SELECT COUNT(*) INTO p_zipnum 
	FROM zipcode
	WHERE state = p_state;
END add_zip2;
/

VARIABLE flag VARCHAR2(10)
VARIABLE zipnum NUMBER

EXECUTE add_zip2('18104', 'Chicago', 'MI', :flag, :zipnum)

PRINT flag
PRINT zipnum

SELECT  * 
FROM zipcode 
WHERE  state = 'MI';
	
ROLLBACK;

EXECUTE add_zip2('48104', 'Ann Arbor', 'MI', :flag, :zipnum)

PRINT flag
PRINT zipnum

SELECT  * 
FROM zipcode 
WHERE  state = 'MI';

ROLLBACK;