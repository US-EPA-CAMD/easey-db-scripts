-- FUNCTION: camdecmps.get_operating_unit_retire_date(date, date)

DROP FUNCTION IF EXISTS camdecmps.get_operating_unit_retire_date(date, date);

CREATE OR REPLACE FUNCTION camdecmps.get_operating_unit_retire_date(
	vbegindate date,
	venddate date)
    RETURNS TABLE(unit_id numeric, retire_date date) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE
BEGIN
	RETURN QUERY
	SELECT UOS.UNIT_ID, END_DATE AS RETIRE_DATE
	FROM CAMD.UNIT_OP_STATUS AS UOS
	WHERE OP_STATUS_CD = 'OPR' AND
		BEGIN_DATE <= vENDDATE AND (
		END_DATE IS NULL OR -- BZ 8022 - fix to include units with RET date during quarter
		END_DATE >= vBEGINDATE
	);
END;
$BODY$;
