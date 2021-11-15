-- FUNCTION: camdecmpswks.format_date_time(date, numeric, numeric)

-- DROP FUNCTION camdecmpswks.format_date_time(date, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.format_date_time(
	_datelabel date,
	_timehour numeric,
	_timeminute numeric)
    RETURNS timestamp without time zone
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE returnVal TIMESTAMP;

BEGIN
IF  _datelabel is not null and _timehour is not null and _timeminute is not null then
      returnVal=_datelabel::TIMESTAMP + (((_timehour)::TEXT || ' hours')::INTERVAL) +( ((_timeminute)::TEXT || ' minutes')::INTERVAL);
elsif _datelabel is not null and _timehour is not null and COALESCE(_timeminute,0)=0 then
      returnVal=_datelabel::TIMESTAMP + ((_timehour)::TEXT || ' hours');
elsif  _datelabel is not null and COALESCE(_timehour,0)=0 then
       returnVal=_datelabel ::TIMESTAMP;
elsif _datelabel is  null then
      returnVal='1/1/1900'::TIMESTAMP;
END IF;

return returnVal;
END;
$BODY$;