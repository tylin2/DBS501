CREATE OR REPLACE FUNCTION Get_Descr(
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
/
SHOW ERRORS;

SET AUTOPRINT ON
VARIABLE description VARCHAR2(150)

EXECUTE :description := Get_Descr('150');
EXECUTE :description := Get_Descr('999');

