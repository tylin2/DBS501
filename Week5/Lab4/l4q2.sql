CREATE OR REPLACE PROCEDURE add_zip(
  p_zip zipcode.zip%TYPE,
  p_city zipcode.city%TYPE,
  p_state zipcode.state%TYPE,
  p_flag OUT VARCHAR2,
  p_zipnum OUT NUMBER
 )
IS
  v_zip zipcode.zip%TYPE;
  
BEGIN
  SELECT zip INTO v_zip 
  FROM zipcode
  WHERE zip = p_zip;
  p_flag := 'FAILURE';
  DBMS_OUTPUT.PUT_LINE('This ZIPCODE ' || p_zip ||' is already in the Dataase. Try again.');
  SELECT COUNT(*) INTO p_zipnum 
  FROM zipcode 
  WHERE state = p_state;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    p_flag := 'SUCCESS';
    INSERT INTO zipcode
	VALUES (p_zip, p_city, p_state, USER, SYSDATE, USER, SYSDATE);
	SELECT COUNT(*) INTO p_zipnum 
	FROM zipcode
	WHERE state = p_state;
END add_zip;
/

VARIABLE flag VARCHAR2(10)
VARIABLE zipnum NUMBER

EXECUTE add_zip('18104', 'Chicago', 'MI', :flag, :zipnum)

PRINT flag
PRINT zipnum

SELECT  * 
FROM zipcode 
WHERE  state = 'MI';
	
ROLLBACK;

EXECUTE add_zip('48104', 'Ann Arbor', 'MI', :flag, :zipnum)

PRINT flag
PRINT zipnum

SELECT  * 
FROM zipcode 
WHERE  state = 'MI';

ROLLBACK;