-- FUNCTION: camdecmpswks.date_add(text, integer, timestamp without time zone)

DROP FUNCTION IF EXISTS camdecmpswks.date_add(text, integer, timestamp without time zone);

CREATE OR REPLACE FUNCTION camdecmpswks.date_add(
	_interval text,
	_change integer,
	_datadate timestamp without time zone)
    RETURNS timestamp without time zone
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
 v_date		timestamp;
begin 
  if _interval = 'quarter' then
   select _datadate::TIMESTAMP + _change * '3 month'::INTERVAL into v_date;
  elsif _interval = 'month' then
   select _datadate::TIMESTAMP + _change * '1 month'::INTERVAL into v_date;
  elsif _interval = 'day' then
   select _datadate::TIMESTAMP + _change * '1 day'::INTERVAL into v_date;
  elsif _interval = 'year' then
   select _datadate::TIMESTAMP + _change * '1 year'::INTERVAL into v_date; 
  elsif _interval = 'hour' then
   select _datadate::TIMESTAMP + _change * '1 hour'::INTERVAL into v_date;
  end if;
  
  return v_date;
     
END;
$BODY$;

-- FUNCTION: camdecmpswks.date_add(text, numeric, timestamp without time zone)

DROP FUNCTION IF EXISTS camdecmpswks.date_add(text, numeric, timestamp without time zone);

CREATE OR REPLACE FUNCTION camdecmpswks.date_add(
	_interval text,
	_change numeric,
	_datadate timestamp without time zone)
    RETURNS timestamp without time zone
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
 v_date		timestamp;
begin 
  if _interval = 'quarter' then
   select _datadate::TIMESTAMP + _change * '3 month'::INTERVAL into v_date;
  elsif _interval = 'month' then
   select _datadate::TIMESTAMP + _change * '1 month'::INTERVAL into v_date;
  elsif _interval = 'day' then
   select _datadate::TIMESTAMP + _change * '1 day'::INTERVAL into v_date;
  elsif _interval = 'year' then
   select _datadate::TIMESTAMP + _change * '1 year'::INTERVAL into v_date; 
  elsif _interval = 'hour' then
   select _datadate::TIMESTAMP + _change * '1 hour'::INTERVAL into v_date;
  elsif _interval = 'minute' then
   select _datadate::TIMESTAMP + _change * '1 minute'::INTERVAL into v_date;
  elsif _interval = 'second' then
   select _datadate::TIMESTAMP + _change * '1 second'::INTERVAL into v_date;
  end if;
  
  return v_date;
     
END;
$BODY$;
