-- View: camdecmpsaux.vw_em_submission_access

DROP VIEW IF EXISTS camdecmpsaux.vw_em_submission_access;

CREATE OR REPLACE VIEW camdecmpsaux.vw_em_submission_access
 AS
SELECT
	em.em_sub_access_id,
	em.mon_plan_id,
	em.rpt_period_id,
	em.access_begin_date,
	em.access_end_date,
	stc.em_sub_type_cd,
	stc.em_sub_type_cd_description,
	em.userid,
	em.add_date,
	em.update_date,
	statc.em_status_cd,
	statc.em_status_cd_description,
	sac.submission_availability_cd as sub_availability_cd,
	sac.sub_avail_cd_description as sub_availability_cd_description,
	em.resub_explanation,
	pl.fac_id,
	pl.oris_code,
	pl.state,
	pl.facility_name,
	rp.calendar_year,
	rp.quarter,
	rp.period_abbreviation,
	rf.report_freq_cd,
	ee.submission_id,
	sc.severity_cd,
	sc.severity_cd_description,
	mp.config AS locations
FROM camdecmpsaux.em_submission_access em
JOIN (
	SELECT
		fac_id,
		mon_plan_id,
		string_agg(d.unit_stack, ', ') AS config
	FROM (
		SELECT
			mpl.mon_plan_id,
			COALESCE(u.fac_id, sp.fac_id) AS fac_id,
			COALESCE(u.unitid, sp.stack_name) AS unit_stack
		FROM camdecmps.monitor_plan_location mpl
		JOIN camdecmps.monitor_location ml USING(mon_loc_id)
		LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
		LEFT JOIN camd.unit u USING (unit_id)
		ORDER BY mon_plan_id, unitid, stack_name
	) AS d
	GROUP BY mon_plan_id, fac_id
) AS mp USING(mon_plan_id)
JOIN camdecmps.monitor_plan_reporting_freq rf
	ON rf.mon_plan_id = em.mon_plan_id AND (
		(rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id IS NULL) OR
		(rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id >= em.rpt_period_id)
	)
JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
JOIN camdecmpsmd.em_status_code statc USING (em_status_cd)
JOIN camdecmpsmd.em_sub_type_code stc USING (em_sub_type_cd)
JOIN camdecmpsmd.submission_availability_code sac
	ON em.sub_availability_cd = sac.submission_availability_cd
JOIN camd.plant pl USING(fac_id)
LEFT JOIN camdecmps.emission_evaluation ee
	ON ee.mon_plan_id = em.mon_plan_id
	AND ee.rpt_period_id = em.rpt_period_id
LEFT JOIN camdecmpsaux.check_session cs
	ON cs.chk_session_id = ee.chk_session_id
LEFT JOIN camdecmpsmd.severity_code sc USING (severity_cd)
GROUP BY em.em_sub_access_id, stc.em_sub_type_cd, statc.em_status_cd, sac.submission_availability_cd, pl.fac_id,
	rp.calendar_year, rp.quarter, rf.report_freq_cd, ee.submission_id, sc.severity_cd, rp.period_abbreviation, mp.config
ORDER BY rpt_period_id DESC, access_begin_date DESC;