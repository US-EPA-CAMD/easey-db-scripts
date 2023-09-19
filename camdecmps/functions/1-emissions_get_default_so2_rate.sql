-- FUNCTION: camdecmps.emissions_get_default_so2_rate(character varying, timestamp without time zone, integer)

DROP FUNCTION IF EXISTS camdecmps.emissions_get_default_so2_rate(character varying, timestamp without time zone, integer);

CREATE OR REPLACE FUNCTION camdecmps.emissions_get_default_so2_rate(
	p_mon_loc_id character varying,
	p_start_date timestamp without time zone,
	p_start_hour integer)
    RETURNS numeric
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
    result numeric;
BEGIN 
    SELECT MAX(DEFAULT_VALUE)
	FROM camdecmps.MONITOR_DEFAULT
	WHERE MON_LOC_ID = p_MON_LOC_ID
	  AND PARAMETER_CD = 'SO2R'
	  AND DEFAULT_PURPOSE_CD = 'F23'
	  AND p_START_DATE + (p_START_HOUR * interval '1 hour') >= BEGIN_DATE + (BEGIN_HOUR * interval '1 hour')
	  AND (
		  END_DATE IS NULL OR
		  p_START_DATE + (p_START_HOUR * interval '1 hour') <= END_DATE + (END_HOUR * interval '1 hour')
	  ) INTO result;

	RETURN result;
END;
$BODY$;

-- FUNCTION: camdecmps.emissions_get_default_so2_rate(character varying, timestamp without time zone, numeric)

DROP FUNCTION IF EXISTS camdecmps.emissions_get_default_so2_rate(character varying, timestamp without time zone, numeric);

CREATE OR REPLACE FUNCTION camdecmps.emissions_get_default_so2_rate(
	p_mon_loc_id character varying,
	p_start_date timestamp without time zone,
	p_start_hour numeric)
    RETURNS numeric
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
    result numeric;
BEGIN 
    SELECT MAX(DEFAULT_VALUE)
	FROM camdecmps.MONITOR_DEFAULT
	WHERE MON_LOC_ID = p_MON_LOC_ID
	  AND PARAMETER_CD = 'SO2R'
	  AND DEFAULT_PURPOSE_CD = 'F23'
	  AND p_START_DATE + (p_START_HOUR * interval '1 hour') >= BEGIN_DATE + (BEGIN_HOUR * interval '1 hour')
	  AND (
		  END_DATE IS NULL OR
		  p_START_DATE + (p_START_HOUR * interval '1 hour') <= END_DATE + (END_HOUR * interval '1 hour')
	  ) INTO result;

	RETURN result;
END;
$BODY$;
