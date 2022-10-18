-- FUNCTION: camdecmpswks.emissions_monitor_default_active(character varying, timestamp without time zone, integer)

-- DROP FUNCTION IF EXISTS camdecmpswks.emissions_monitor_default_active(character varying, timestamp without time zone, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.emissions_get_default_so2_rate(
	p_mon_loc_id character varying,
	p_start_date timestamp without time zone,
	p_start_hour integer)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    result NUMERIC(15,4);
begin 

    SELECT result = MAX(DEFAULT_VALUE)
	FROM camdecmpswks.MONITOR_DEFAULT
	WHERE MON_LOC_ID = p_MON_LOC_ID
	  AND PARAMETER_CD = 'SO2R'
	  AND DEFAULT_PURPOSE_CD = 'F23'
	  AND (DATEADD(hour, p_START_HOUR, p_START_DATE) >= DATEADD(hour, BEGIN_HOUR, BEGIN_DATE))
	  AND (  (END_DATE IS NULL) 
	      OR (DATEADD(hour, p_START_HOUR, p_START_DATE) <= DATEADD(hour, END_HOUR, END_DATE)));

	RETURN result;
    
END;
$BODY$;

ALTER FUNCTION camdecmpswks.emissions_monitor_default_active(character varying, timestamp without time zone, integer)
    OWNER TO "uImcwuf4K9dyaxeL";
