CREATE OR REPLACE PROCEDURE show_bizdays(
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
/
SHOW ERRORS;