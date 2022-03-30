ACCEPT location_id PROMPT 'Enter valid Location Id: '
DECLARE
	dep NUMBER(4,0) := &location_id;
	num_dep NUMBER;
	num_emp NUMBER;
BEGIN
	SELECT  COUNT(location_id) INTO num_dep
	FROM departments
	WHERE location_id = dep
	GROUP BY location_id;
	SELECT  COUNT(d.location_id) INTO num_emp
	FROM employees e
	INNER JOIN departments d ON e.department_id = d.department_id
	WHERE d.location_id = dep
	GROUP BY d.location_id;
	<<Outer_Loop>>
	FOR i IN 1..num_dep LOOP
		DBMS_OUTPUT.PUT_LINE('Outer Loop: Department #' || i);
		<<Inner_Loop>>
		FOR j IN 1..num_emp LOOP
			DBMS_OUTPUT.PUT_LINE('* Inner Loop: Employee #' || j);
		END LOOP Inner_Loop;	
	END LOOP Outer_Loop;
END;
/