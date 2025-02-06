DROP FUNCTION IF EXISTS camdecmpsaux.get_submission_in_window(character varying, numeric, date, date) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpsaux.get_submission_in_window(
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
	
	SELECT SQ.submission_id
	INTO v_submission_id
	FROM camdecmpsaux.submission_set SS
	JOIN camdecmpsaux.submission_queue SQ USING(submission_set_id)
	WHERE SS.mon_plan_id = v_mon_plan_id
		AND SQ.rpt_period_id = v_rpt_period_id
		AND SQ.process_cd = 'EM'
		AND DATE(SQ.queued_time) = DATE(v_begin_date)
	ORDER BY SQ.queued_time DESC
	LIMIT 1;
	
	return v_submission_id;
END;
$BODY$;
