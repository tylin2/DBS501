CREATE OR REPLACE PACKAGE com_pack 
IS

FUNCTION validate_com (p_com   IN employees.commission_pct%type)
RETURN  BOOLEAN;
PROCEDURE  modify_com  (p_com  IN employees.commission_pct%type);
END Lab5;
/


CREATE OR REPLACE PACKAGE BODY com_pack  IS

FUNCTION validate_com (p_com   IN employees.commission_pct%type)

RETURN  BOOLEAN   IS

             v_min      employees.commission_pct%type;

             v_max     employees.commission_pct%type;

BEGIN

            SELECT MIN(commission_pct), MAX(commission_pct)

            INTO      v_min, v_max

            FROM    employees;

IF  p_com < v_min THEN

            RETURN FALSE;

            ELSIF  p_com  > v_max  THEN

                        RETURN  NULL;

            ELSE

                        RETURN   TRUE;

            END IF;

END    validate_com;

 

PROCEDURE  modify_com  (p_com  IN employees.commission_pct%type)

IS

BEGIN

            IF  validate_com (p_com) THEN

                        DBMS_OUTPUT.PUT_LINE('Good Commission input.');

            ELSIF  validate_com (p_com) = NULL THEN

                     DBMS_OUTPUT.PUT_LINE('Invalid Commission input.');

            ELSE

               DBMS_OUTPUT.PUT_LINE('Commission must be higher than entered.');

            END IF;

EXCEPTION

            WHEN NO_DATA_FOUND THEN

                        DBMS_OUTPUT.PUT_LINE('There is NO data.');

            WHEN OTHERS  THEN

                        DBMS_OUTPUT.PUT_LINE('Some error has happened');

END  modify_com;

END  com_pack;

/

/*
a) Commission must be higher than entered.
b) Good Commission input.
c) Commission must be higher than entered.
*/