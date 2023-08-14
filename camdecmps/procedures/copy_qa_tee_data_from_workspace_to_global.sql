-- PROCEDURE: camdecmps.copy_qa_tee_data_from_workspace_to_global(character varying)

-- DROP PROCEDURE IF EXISTS camdecmps.copy_qa_tee_data_from_workspace_to_global(character varying);

CREATE OR REPLACE PROCEDURE camdecmps.copy_qa_tee_data_from_workspace_to_global(
	teeid character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camdecmps.test_extension_exemption
	WHERE test_extension_exemption_id = teeId;

	INSERT INTO camdecmps.test_extension_exemption(
		test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, submission_id, submission_availability_cd
	)
	SELECT
		test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, submission_id, 'UPDATED' 
	FROM camdecmpswks.test_extension_exemption
	WHERE test_extension_exemption_id = teeId;
END;
$BODY$;
