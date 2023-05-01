-- View: camdecmpswks.vw_test_extension_exemption_eval_and_submit

DROP VIEW IF EXISTS camdecmpswks.vw_test_extension_exemption_eval_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_test_extension_exemption_eval_and_submit
AS
	SELECT
		p.oris_code,
		p.facility_name,
		mpl.mon_plan_id,
		COALESCE(u.unitid, sp.stack_name) AS location_info,
		tee.test_extension_exemption_id,
		tee.extens_exempt_cd,
		tee.mon_loc_id,
		COALESCE(ms.system_identifier, com.component_identifier) AS system_component_identifier,
		tee.rpt_period_id,
		tee.userid,
		COALESCE(tee.update_date, tee.add_date) AS update_date,
		tee.eval_status_cd,
		tee.submission_availability_cd,
		tee.fuel_cd,
		tee.hours_used,
		tee.span_scale_cd,
		rp.period_abbreviation
	FROM camd.plant p
	JOIN camdecmpswks.monitor_plan mp USING (fac_id)
	JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
	JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
	JOIN camdecmpswks.test_extension_exemption tee USING (mon_loc_id)
	LEFT JOIN camdecmpswks.monitor_system ms USING (mon_sys_id)
	LEFT JOIN camdecmpswks.component com USING (component_id)
	LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = tee.rpt_period_id
	LEFT JOIN camd.unit u USING (unit_id)
	LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
	ORDER BY p.oris_code, p.facility_name, mp.mon_plan_id;
