-- FUNCTION: camdecmpswks.check_date_hour(date, numeric, integer)

DROP FUNCTION IF EXISTS camdecmpswks.check_date_hour(date, numeric, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.check_date_hour(
	indate date,
	inhour numeric,
	inother integer DEFAULT NULL::integer)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
 v_result		integer default null;
begin 
   if
      (Indate IS NULL AND InHour IS NULL) then
		 v_Result = Inother;
	  elsif (Indate IS NOT NULL AND InHour IS NULL) then
		 v_Result = 0;
	  elsif (Indate IS NULL AND InHour IS NOT NULL) then
		 v_Result = 0;
	  elsif (InHour < 0 OR InHour > 23) then
		 v_Result = 0;
	  ELSE
		 v_Result = 1;
    end if;
	
	RETURN v_Result;
    
END;
$BODY$;
