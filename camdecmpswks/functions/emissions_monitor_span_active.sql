-- FUNCTION: camdecmpswks.emissions_monitor_default_active(timestamp without time zone, numeric, timestamp without time zone, numeric, timestamp without time zone, numeric)

-- DROP FUNCTION IF EXISTS camdecmpswks.emissions_monitor_default_active(timestamp without time zone, numeric, timestamp without time zone, numeric, timestamp without time zone, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.emissions_monitor_span_active(
	p_MS_BEGIN_DATE DATE,
	p_MS_BEGIN_HOUR NUMERIC,
	p_MS_END_DATE DATE,
	p_MS_END_HOUR NUMERIC,
	p_HOD_BEGIN_DATE DATE,
	p_HOD_BEGIN_HOUR TEXT)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE

     v_HOD_BEGIN_DATETIME TIMESTAMP;
	 v_RESULT INTEGER;
 
begin 
	
	v_HOD_BEGIN_DATETIME := p_HOD_BEGIN_DATE + (p_HOD_BEGIN_HOUR || ' hour')::interval;

	IF (v_HOD_BEGIN_DATETIME >= (p_MS_BEGIN_DATE + (p_MS_BEGIN_HOUR || ' hour')::interval))
		AND ((p_MS_END_DATE IS NULL) 
	      OR (v_HOD_BEGIN_DATETIME <= (p_MS_END_DATE + (p_MS_END_HOUR || ' hour')::interval))) THEN

		v_RESULT := 1;

	ELSE

		v_RESULT := 0;
		
	END IF;

	RETURN v_RESULT;
    
END;
$BODY$;
