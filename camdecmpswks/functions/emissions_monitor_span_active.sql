-- FUNCTION: camdecmpswks.emissions_monitor_span_active(date, numeric, date, numeric, date, text)

DROP FUNCTION IF EXISTS camdecmpswks.emissions_monitor_span_active(date, numeric, date, numeric, date, text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.emissions_monitor_span_active(
	p_ms_begin_date date,
	p_ms_begin_hour numeric,
	p_ms_end_date date,
	p_ms_end_hour numeric,
	p_hod_begin_date date,
	p_hod_begin_hour text)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
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

-- FUNCTION: camdecmpswks.emissions_monitor_span_active(timestamp without time zone, integer, timestamp without time zone, integer, timestamp without time zone, integer)

DROP FUNCTION IF EXISTS camdecmpswks.emissions_monitor_span_active(timestamp without time zone, integer, timestamp without time zone, integer, timestamp without time zone, integer) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.emissions_monitor_span_active(
	p_ms_begin_date timestamp without time zone,
	p_ms_begin_hour integer,
	p_ms_end_date timestamp without time zone,
	p_ms_end_hour integer,
	p_hod_begin_date timestamp without time zone,
	p_hod_begin_hour integer)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
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

-- FUNCTION: camdecmpswks.emissions_monitor_span_active(date, numeric, date, numeric, date, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.emissions_monitor_span_active(date, numeric, date, numeric, date, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.emissions_monitor_span_active(
	vbegindate date,
	vbeginhour numeric,
	venddate date,
	vendhour numeric,
	vhodbegindate date,
	vhodbeginhour numeric)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	vResult integer;
	vHodDateTime timestamp;
BEGIN
	vHodDateTime := vHodBeginDate::TIMESTAMP + ((vHodBeginHour || ' hours')::INTERVAL);

	IF (
		vHodDateTime >= (vBeginDate::TIMESTAMP + ((vBeginHour || ' hours')::INTERVAL)) AND
		(
			(vEndDate IS NULL) OR
			(vHodDateTime <= (vEndDate::TIMESTAMP + ((vEndHour || ' hours')::INTERVAL)))
		)
	)
	THEN
		vResult := 1;
	ELSE
		vResult = 0;
	END IF;

	RETURN vResult;
END;
$BODY$;
