-- FUNCTION: camdecmps.emissions_monitor_default_active(timestamp without time zone, numeric, timestamp without time zone, numeric, timestamp without time zone, numeric)

DROP FUNCTION IF EXISTS camdecmps.emissions_monitor_default_active(timestamp without time zone, numeric, timestamp without time zone, numeric, timestamp without time zone, numeric);

CREATE OR REPLACE FUNCTION camdecmps.emissions_monitor_default_active(
	p_md_begin_date timestamp without time zone,
	p_md_begin_hour numeric,
	p_md_end_date timestamp without time zone,
	p_md_end_hour numeric,
	p_hod_begin_date timestamp without time zone,
	p_hod_begin_hour numeric)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE

     hodBeginDateTime TIMESTAMP;
	 result INTEGER;
 
begin 
	
	hodBeginDateTime := p_HOD_BEGIN_DATE + (p_HOD_BEGIN_HOUR || ' hour')::interval;

	IF (hodBeginDateTime >= (p_MD_BEGIN_DATE + (p_MD_BEGIN_HOUR || ' hour')::interval))
		AND ((p_MD_END_DATE IS NULL) 
	      OR (hodBeginDateTime <= (p_MD_END_DATE + (p_MD_END_HOUR || ' hour')::interval))) THEN

		result := 1;
	ELSE
		result := 0;
	END IF;

	RETURN result;
    
END;
$BODY$;
