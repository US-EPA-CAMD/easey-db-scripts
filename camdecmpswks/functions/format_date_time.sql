-- FUNCTION: camdecmpswks.format_date_time(date, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.format_date_time(date, numeric, numeric) CASCADE;

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
      returnVal=_datelabel::TIMESTAMP + ((_timehour)::TEXT || ' hours')::INTERVAL;
elsif  _datelabel is not null and COALESCE(_timehour,0)=0 then
       returnVal=_datelabel ::TIMESTAMP;
elsif _datelabel is  null then
      returnVal='1/1/1900'::TIMESTAMP;
END IF;

return returnVal;
END;
$BODY$;

DROP FUNCTION IF EXISTS camdecmpswks.format_date_time(date, numeric, numeric, date) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.format_date_time(
	_datelabel date,
	_timehour numeric,
	_timeminute numeric,
	_defaultDate date)
    RETURNS timestamp without time zone
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE returnVal TIMESTAMP;

BEGIN
IF  _datelabel is not null and _timehour is not null and _timeminute is not null then
      returnVal=_datelabel::TIMESTAMP + (((_timehour)::TEXT || ' hours')::INTERVAL) +( ((_timeminute)::TEXT || ' minutes')::INTERVAL);
elsif _datelabel is not null and _timehour is not null and COALESCE(_timeminute,0)=0 then
      returnVal=_datelabel::TIMESTAMP + ((_timehour)::TEXT || ' hours')::INTERVAL;
elsif  _datelabel is not null and COALESCE(_timehour,0)=0 then
       returnVal=_datelabel ::TIMESTAMP;
elsif _datelabel is null then
	IF _defaultDate is null then
		returnVal = null;
	ELSE
		returnVal = _defaultDate::TIMESTAMP;
	END IF;
END IF;

return returnVal;
END;
$BODY$;