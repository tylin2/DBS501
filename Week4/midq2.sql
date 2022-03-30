SET  SERVEROUTPUT ON 

SET   VERIFY  OFF

ACCEPT  let PROMPT  'Enter first two letters of the last name: '

DECLARE

   CURSOR  c1 IS

   SELECT   zip, city, last_name

   FROM      student JOIN zipcode USING (zip)

   WHERE    last_name  LIKE '&&let%'

   AND     student_id < 121

   ORDER  BY 1;

   TYPE   zip_type IS  RECORD (

              zip_code      zipcode.zip%TYPE,

              v_city           zipcode.city%TYPE,

              v_name         VARCHAR2(20) );

 

    zip_rec           ZIP_TYPE;

    total   INTEGER := 0;

BEGIN

      OPEN    c1;

      LOOP     

           FETCH  c1 INTO zip_rec;                 

           EXIT  WHEN  c1%NOTFOUND;

     DBMS_OUTPUT.PUT_LINE('Zip code  : ' || zip_rec.zip_code || ' has student  ' || zip_rec.v_name  || ' who lives in  '  || zip_rec.v_city);

         total := c1%ROWCOUNT;

       END LOOP;

CLOSE  c1;

    IF  total = 0 then

       DBMS_OUTPUT.PUT_LINE('These letters are student empty. Please, try again. ');

   ELSE       

      DBMS_OUTPUT.PUT_LINE('************************************');

      DBMS_OUTPUT.PUT_LINE('Total # of students  under ' || '&let'  || ' is ' ||  total);

    END  IF;                            

END;

