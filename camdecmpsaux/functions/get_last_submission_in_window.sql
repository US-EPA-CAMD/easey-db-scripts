-- FUNCTION: camdecmpsaux.get_last_submission_in_window(character varying, numeric, date, date)

DROP FUNCTION IF EXISTS camdecmpsaux.get_last_submission_in_window(character varying, numeric, date, date) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpsaux.get_last_submission_in_window(
	v_mon_plan_id character varying,
	v_rpt_period_id numeric,
	v_begin_date date,
	v_end_date date)
    RETURNS bigint
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	v_submission_id bigint;
BEGIN
    v_submission_id := null;
	
	SELECT S.submission_id
	INTO v_submission_id
	FROM camdecmpsaux.submission_set SS
	JOIN camdecmpsaux.submission S USING(submission_set_id)
	WHERE SS.mon_plan_id = v_mon_plan_id
		AND S.rpt_period_id = v_rpt_period_id
		AND S.submission_type_cd = 'EM'
		AND S.add_date >= v_begin_date
		AND S.add_date <= v_end_date
	ORDER BY S.add_date DESC
	LIMIT 1;
	
	return v_submission_id;
END;
$BODY$;
