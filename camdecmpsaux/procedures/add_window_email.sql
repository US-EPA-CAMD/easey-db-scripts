-- PROCEDURE: camdecmpsaux.add_window_email(numeric, character varying, character varying, numeric, bigint, text, text)

DROP PROCEDURE IF EXISTS camdecmpsaux.add_window_email(numeric, character varying, character varying, numeric, bigint, text, text);

CREATE OR REPLACE PROCEDURE camdecmpsaux.add_window_email(
	v_event_action_id numeric,
	v_email_type character varying,
	v_mon_plan_id character varying,
	v_rpt_period_id numeric,
	v_em_sub_access_id bigint,
	INOUT v_result text,
	INOUT v_error_msg text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE

	FAC_ID numeric;
	
BEGIN
	SELECT p.fac_id
	INTO FAC_ID
	FROM camd.plant p
	JOIN camdecmps.monitor_plan mp USING(fac_id)
	WHERE mp.mon_plan_id = v_mon_plan_id;
	
	INSERT INTO camdecmpsaux.email_to_process(fac_id, email_type, event_code, mon_plan_id, rpt_period_id, em_sub_access_id, status_cd)
	VALUES (FAC_ID, v_email_type, v_event_action_id, v_mon_plan_id, v_rpt_period_id, v_em_sub_access_id, 'QUEUED');
END
$BODY$;
