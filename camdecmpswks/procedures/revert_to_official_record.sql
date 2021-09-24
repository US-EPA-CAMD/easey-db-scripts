-- PROCEDURE: camdecmpswks.revert_to_official_record(text)

-- DROP PROCEDURE camdecmpswks.revert_to_official_record(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.revert_to_official_record(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  	CALL camdecmpswks.delete_workspace_monitor_plan(monplanid);
  	CALL camdecmpswks.copy_monitor_plan_to_workspace(monplanid);
	
	-- UPDATE MONITOR PLAN
	UPDATE camdecmpswks.monitor_plan wks
	SET fac_id = mp.fac_id,
		config_type_cd = mp.config_type_cd,
		last_updated = mp.last_updated,
		updated_status_flg = mp.updated_status_flg,
		needs_eval_flg = mp.needs_eval_flg,
		chk_session_id = mp.chk_session_id,
		userid = mp.userid,
		add_date = mp.add_date,
		update_date = mp.update_date,
		submission_id = mp.submission_id,
		submission_availability_cd = mp.submission_availability_cd,
		pending_status_cd = null,
		begin_rpt_period_id = mp.begin_rpt_period_id,
		end_rpt_period_id = mp.end_rpt_period_id,
    last_evaluated_date = mp.last_evaluated_date
	FROM camdecmps.monitor_plan mp
	WHERE wks.mon_plan_id = mp.mon_plan_id
		AND mp.mon_plan_id = monPlanId
		AND wks.mon_plan_id = monPlanId;
END;
$BODY$;
