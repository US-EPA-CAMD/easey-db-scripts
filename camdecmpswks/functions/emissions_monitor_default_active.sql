CREATE OR REPLACE FUNCTION camdecmpswks.emissions_monitor_default_active(
	p_MD_BEGIN_DATE TIMESTAMP,
	p_MD_BEGIN_HOUR INTEGER,
	p_MD_END_DATE TIMESTAMP,
	p_MD_END_HOUR INTEGER,
	p_HOD_BEGIN_DATE TIMESTAMP,
	p_HOD_BEGIN_HOUR INTEGER
    )
    RETURNS integer
    LANGUAGE 'plpgsql'
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
