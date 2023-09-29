-- FUNCTION: camdecmpswks.get_initial_values(character varying, date)

DROP FUNCTION IF EXISTS camdecmpswks.get_initial_values(character varying, date) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.get_initial_values(
	monplanid character varying,
	defaultevaluationenddate date)
    RETURNS TABLE(evaluationenddate date, maximumfuturedate date, result character, errormessage character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE
    errMsg text;
	errState text;
    errContext text;
	firstMethodDatePlusOneYear date;
	nowPlusOneYear date := CURRENT_DATE + INTERVAL '1 year';
BEGIN
	-- Earliest Method Begin Date Plus One Year
	SELECT MIN(mth.begin_date) + INTERVAL '1 year' 	INTO firstMethodDatePlusOneYear
	 FROM camdecmpswks.monitor_plan_location mpl
	JOIN camdecmpswks.monitor_method mth 	ON mth.mon_loc_id = mpl.mon_loc_id
	  WHERE mpl.mon_plan_id = monplanid;

	-- Determine Evaluation End Date
	IF 	(firstMethodDatePlusOneYear IS NULL) OR
		(defaultEvaluationEndDate >= firstMethodDatePlusOneYear)
	THEN
		evaluationEndDate := defaultEvaluationEndDate;
	ELSE
		evaluationEndDate := firstMethodDatePlusOneYear;
	END IF;

	-- Determine Maximum Future Date
	IF 	(firstMethodDatePlusOneYear IS NULL) OR
		(nowPlusOneYear >= firstMethodDatePlusOneYear)
	THEN
		maximumFutureDate := nowPlusOneYear;
	ELSE
		maximumFutureDate := firstMethodDatePlusOneYear;
	END IF;

	result := 'T';
	errorMessage := '';
RETURN NEXT;
	EXCEPTION WHEN OTHERS THEN
    	GET STACKED DIAGNOSTICS
            errState   = RETURNED_SQLSTATE,
            errMsg = MESSAGE_TEXT,
            errContext = PG_EXCEPTION_CONTEXT;
		errorMessage := 'SQL State: ' || errState || '; Message: ' || errMsg || '; Context: ' || errContext;
		result := 'F';
END;
$BODY$;
