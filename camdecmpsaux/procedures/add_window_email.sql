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

	MON_PLAN_INFO Record;
	LOCATION_LIST text;
	PERIOD_ABR character varying(32);
	EM_SUB_ACCESS_WINDOW date;
	
BEGIN
	SELECT vmp.fac_id, vmp.state, vmp.oris_code, vmp.facility_name, vmp.locations
	INTO MON_PLAN_INFO
	FROM camdecmps.vw_monitor_plan vmp
	WHERE vmp.mon_plan_id = v_mon_plan_id;
	
	SELECT period_abbreviation INTO PERIOD_ABR FROM camdecmpsmd.reporting_period WHERE rpt_period_id = v_rpt_period_id;
	
	SELECT access_begin_date INTO EM_SUB_ACCESS_WINDOW FROM camdecmpsaux.em_submission_access WHERE em_sub_access_id = v_em_sub_access_id;	
	
	INSERT INTO camdecmpsaux.email_to_process(fac_id,
											  email_type,
											  event_code,
											  mon_plan_id,
											  rpt_period_id,
											  em_sub_access_id,
											  context,
											  status_cd,
											  queued_time)
		VALUES (MON_PLAN_INFO.fac_id,
				v_email_type,
				v_event_action_id,
				v_mon_plan_id,
				v_rpt_period_id,
				v_em_sub_access_id,
				jsonb_build_object('plantName', MON_PLAN_INFO.facility_name, 
								   'plantState', MON_PLAN_INFO.state, 
								   'orisCode', MON_PLAN_INFO.oris_code, 
								   'locationList', MON_PLAN_INFO.locations, 
								   'periodAbbreviation', PERIOD_ABR, 
								   'windowOpenDate', EM_SUB_ACCESS_WINDOW)::text,
				'QUEUED',
				CURRENT_TIMESTAMP);
END
$BODY$;
