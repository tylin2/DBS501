/*
A) Write the Package specification called Lab5 for 
the Procedure and Function created for this Lab 
*/

CREATE OR REPLACE PACKAGE Lab5 
IS

FUNCTION Get_Descr(v_secID section.section_id%TYPE)
RETURN VARCHAR2;
PROCEDURE show_bizdays(v_date DATE := SYSDATE,v_days NUMBER := 31);
END Lab5;
/

/*
B) Then write the Package Body and compile without warnings. 
*/
CREATE OR REPLACE PACKAGE BODY Lab5 
IS

FUNCTION Get_Descr(
v_secID section.section_id%TYPE
)
RETURN VARCHAR2
IS

v_desc course.description%TYPE;

BEGIN

SELECT c.description INTO v_desc 
FROM course c
JOIN section s 
ON c.course_no = s.course_no
WHERE s.section_id = v_secID;

RETURN 'Course Description for Section Id ' || v_secID || ' is ' || v_desc;		

EXCEPTION
 WHEN NO_DATA_FOUND THEN			
	RETURN 'There is NO such Section id: ' || v_secID;	 
END Get_Descr;

PROCEDURE show_bizdays(
  v_date DATE := SYSDATE,
  v_days NUMBER := 31
)
IS
  v_i NUMBER := 1;
  v_count NUMBER := 1;  
BEGIN
  WHILE TRUE LOOP
    IF v_i <= v_days THEN	  
      IF TO_CHAR(v_date + v_i, 'D') NOT IN ('1', '7') THEN			
        DBMS_OUTPUT.PUT_LINE('The index is : ' || v_count || ' and the table value is: ' || TO_CHAR(v_date + v_i));  
		v_count := v_count + 1;	
      END IF;
	  v_i := v_i + 1;
    ELSE
      EXIT;
    END IF;
  END LOOP;
END show_bizdays;

END Lab5;
/
SHOW ERRORS;

/*
C) Test your Package by providing input as for Question 2)
*/
execute Lab5.show_bizdays;
execute Lab5.show_bizdays(sysdate+7, 10);