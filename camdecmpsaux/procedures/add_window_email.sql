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

	PLANT_INFO Record;
	LOCATION_LIST text;
	PERIOD_ABR character varying(32);
	EM_SUB_ACCESS_WINDOW date;
	
BEGIN
	SELECT p.fac_id, p.state, p.oris_code, p.facility_name
	INTO PLANT_INFO
	FROM camd.plant p
	JOIN camdecmps.monitor_plan mp USING(fac_id)
	WHERE mp.mon_plan_id = v_mon_plan_id;
	
	SELECT camdecmpsaux.get_mp_location_list(v_mon_plan_id) INTO LOCATION_LIST;
	
	SELECT period_abbreviation INTO PERIOD_ABR FROM camdecmpsmd.reporting_period WHERE rpt_period_id = v_rpt_period_id;
	
	SELECT access_begin_date INTO EM_SUB_ACCESS_WINDOW FROM camdecmpsaux.em_submission_access WHERE em_sub_access_id = v_em_sub_access_id;
	
	
	INSERT INTO camdecmpsaux.email_to_process(fac_id, email_type, event_code, mon_plan_id, rpt_period_id, em_sub_access_id, context, status_cd)
	VALUES (PLANT_INFO.fac_id, v_email_type, v_event_action_id, v_mon_plan_id, v_rpt_period_id, v_em_sub_access_id, jsonb_build_object('plantName', PLANT_INFO.facility_name, 'plantState', PLANT_INFO.state, 'orisCode', PLANT_INFO.oris_code, 'locationList', LOCATION_LIST, 'periodAbbreviation', PERIOD_ABR, 'windowOpenDate', EM_SUB_ACCESS_WINDOW) ::text ,'QUEUED');
END
$BODY$;
