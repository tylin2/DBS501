ACCEPT  inst  PROMPT  'Enter a valid Instructor Id '

DECLARE

        CURSOR  c1  IS

        SELECT  section_id

        FROM     section

        WHERE  instructor_id = &inst

        ORDER  BY 1;

        v_flag       CHAR(1);

       sec_rec     c1%ROWTYPE; 

       v_enrol     NUMBER(3);

       counter     NUMBER(3) := 0;

       tot#           NUMBER(3) := 0;

       e_many_students      EXCEPTION;

BEGIN

       SELECT 'Y'   INTO v_flag FROM Instructor

       WHERE  instructor_id =  &inst;
	   
	   FOR i IN c1 LOOP
			SELECT COUNT(e.section_id) INTO v_enrol
			FROM section s
			LEFT JOIN enrollment e ON s.section_id=e.section_id
			WHERE s.section_id = i.section_id
			GROUP BY e.section_id;
			IF v_enrol >= 8 THEN
				DBMS_OUTPUT.PUT_LINE('There are many students for section Id '|| i.section_id);
				counter := counter + 1;
			ELSIF v_enrol > 0 THEN 
				DBMS_OUTPUT.PUT_LINE('There are '|| v_enrol || ' students for section ID ' || i.section_id);
				counter := counter + 1;					
			END IF;
			tot# := tot# + v_enrol;			
	   END LOOP;
	   
	   IF tot# > 0 THEN
			DBMS_OUTPUT.PUT_LINE('=================================================');
			DBMS_OUTPUT.PUT_LINE('There are ' || counter ||' non-empty sections for instructor with Id of ' || '&inst');
			DBMS_OUTPUT.PUT_LINE('There are ' || tot# ||' students enrolled for this instructor altogether. ');
		ELSE
			DBMS_OUTPUT.PUT_LINE('This  instructor with the Id of ' || '&inst' ||' does NOT have any section scheduled. ');
	   END IF;	   
	   
EXCEPTION
	WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('There is NO instructor with the Id of '|| '&inst');

END;
/



