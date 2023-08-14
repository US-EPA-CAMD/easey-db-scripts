-- PROCEDURE: camdecmps.copy_qa_qce_data_from_workspace_to_global(character varying)

-- DROP PROCEDURE IF EXISTS camdecmps.copy_qa_qce_data_from_workspace_to_global(character varying);

CREATE OR REPLACE PROCEDURE camdecmps.copy_qa_qce_data_from_workspace_to_global(
	qceid character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	DELETE FROM camdecmps.qa_cert_event
	WHERE qa_cert_event_id = qceId;
	
	DELETE FROM camdecmps.qa_cert_event_supp_data
	WHERE qa_cert_event_id = qceId;

	INSERT INTO camdecmps.qa_cert_event(
		mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, qa_cert_event_id, submission_id, submission_availability_cd
	)
	SELECT
		mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, qa_cert_event_id, submission_id, 'UPDATED'
	FROM camdecmpswks.qa_cert_event
	WHERE qa_cert_event_id = qceId;
	
	INSERT INTO camdecmps.qa_cert_event_supp_data(
		qa_cert_event_supp_data_id, qa_cert_event_id, qa_cert_event_supp_data_cd, qa_cert_event_supp_date_cd, count_from_datehour, count, count_from_included_ind, mon_loc_id, rpt_period_id, delete_ind, userid, add_date, update_date
	)
	SELECT
		a.qa_cert_event_supp_data_id, a.qa_cert_event_id, a.qa_cert_event_supp_data_cd, a.qa_cert_event_supp_date_cd, a.count_from_datehour, a.count, a.count_from_included_ind, a.mon_loc_id, a.rpt_period_id, a.delete_ind, a.userid, a.add_date, a.update_date
	FROM camdecmpswks.qa_cert_event_supp_data AS a
	JOIN camdecmpswks.qa_cert_event USING(qa_cert_event_id)
	WHERE qa_cert_event_id = qceId;
END;
$BODY$;
