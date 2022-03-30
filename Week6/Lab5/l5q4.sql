/*
A) Now OVERLOAD your Package with NEW variation of Procedure show_bizdays
that will accept only ONE input parameter - Start Date and will 
prompt user to enter how many days are needed to show 
*/

CREATE OR REPLACE PACKAGE Lab5 
IS
FUNCTION Get_Descr(v_secID section.section_id%TYPE)
RETURN VARCHAR2;
PROCEDURE show_bizdays(v_date DATE,v_days NUMBER);
PROCEDURE show_bizdays(v_date DATE := SYSDATE);
END Lab5;
/

/*
B) Compile your package specification and body without warnings
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
  v_date DATE,
  v_days NUMBER
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

PROCEDURE show_bizdays(
  v_date DATE := SYSDATE
)
IS
  v_i NUMBER := 1;
  v_count NUMBER := 1;
  how_many_days NUMBER := 0;
BEGIN
  how_many_days := &how_many_days;
  WHILE TRUE LOOP
    IF v_i <= how_many_days THEN	  
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
C) Test your OVERLOADED Procedure  (like for Q2 examples) by using your Package
*/
undefine how_many_days;
execute Lab5.show_bizdays;
undefine how_many_days;

execute Lab5.show_bizdays(sysdate+7);