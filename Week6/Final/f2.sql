CREATE OR REPLACE FUNCTION get_sec_num(
v_i VARCHAR2
)
RETURN NUMBER
IS

v_total NUMBER := 0;
v_len NUMBER := LENGTH(v_i);

CURSOR c1
	IS
		SELECT COUNT(e.section_id) sec, z.city
        FROM enrollment e
        LEFT JOIN student s ON e.student_id = s.student_id
        LEFT JOIN zipcode z ON s.zip = z.zip
		GROUP BY z.city;

BEGIN

FOR i IN c1 LOOP
EXIT  WHEN  c1%NOTFOUND;
        IF UPPER(SUBSTR(i.city,1,v_len)) = UPPER(v_i) THEN
            v_total := v_total + i.sec;
        END IF;
END LOOP;
RETURN v_total;	 
END get_sec_num;
/
SHOW ERRORS;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Number of sections is ' || get_sec_num('Mon'));
END;
/

