-- FUNCTION: camdecmpsaux.has_active_rep(numeric)

DROP FUNCTION IF EXISTS camdecmpsaux.has_active_rep(numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpsaux.has_active_rep(
	inupid numeric)
    RETURNS character
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	REPCOUNT integer;
	HASREP char(1) := 'F';
BEGIN
    SELECT COUNT(F.PPL_ID)
    INTO REPCOUNT
    FROM CAMD.PLANT_PERSON F
    JOIN CAMD.UNIT U ON U.FAC_ID = F.FAC_ID
    JOIN CAMD.UNIT_PROGRAM UP ON UP.UNIT_ID = U.UNIT_ID
    WHERE F.END_DATE IS NULL
        AND F.RESPONSIBILITY_ID = 'PRM'
        AND UP.UP_ID = INUPID;

    IF REPCOUNT > 0 THEN
        HASREP := 'T';
    END IF;

    RETURN HASREP;
END;
$BODY$;
