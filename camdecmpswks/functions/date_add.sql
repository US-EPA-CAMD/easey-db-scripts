-- FUNCTION: camdecmpswks.date_add(text, integer, date)

-- DROP FUNCTION camdecmpswks.date_add(text, integer, date);

CREATE OR REPLACE FUNCTION camdecmpswks.date_add(
	_interval text,
	_change integer,
	_datadate date)
    RETURNS date
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
 v_date		date;
begin 
  if _interval = 'quarter' then
   select _datadate::TIMESTAMP + _change *'3 month'::INTERVAL into v_date;
   return v_date;
   end if;
    
END;
$BODY$;
