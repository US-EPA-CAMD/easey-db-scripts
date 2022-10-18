-- FUNCTION: camdecmpswks.emissions_monitor_default_active(timestamp without time zone, integer, timestamp without time zone, integer, timestamp without time zone, integer)

-- DROP FUNCTION IF EXISTS camdecmpswks.emissions_monitor_default_active(timestamp without time zone, integer, timestamp without time zone, integer, timestamp without time zone, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.emissions_monitor_default_active(
	p_md_begin_date timestamp without time zone,
	p_md_begin_hour numeric,
	p_md_end_date timestamp without time zone,
	p_md_end_hour numeric,
	p_hod_begin_date timestamp without time zone,
	p_hod_begin_hour numeric)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE

     hodBeginDateTime TIMESTAMP;
	 result INTEGER;
 
begin 

    hodBeginDateTime := DATEADD(hour, p_HOD_BEGIN_HOUR, p_HOD_BEGIN_DATE);

	IF (hodBeginDateTime >= DATEADD(hour, p_MD_BEGIN_HOUR, p_MD_BEGIN_DATE))
		AND ((p_MD_END_DATE IS NULL) 
	      OR (hodBeginDateTime <= DATEADD(hour, p_MD_END_HOUR, p_MD_END_DATE))) THEN

		result := 1;
	ELSE
		result := 0;
	END IF;

	RETURN result;
    
END;
$BODY$;

ALTER FUNCTION camdecmpswks.emissions_monitor_default_active(timestamp without time zone, integer, timestamp without time zone, integer, timestamp without time zone, integer)
    OWNER TO "uImcwuf4K9dyaxeL";
