-- View: camdecmpswks.vw_em_eval_and_submit

DROP VIEW IF EXISTS camdecmpswks.vw_em_eval_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_em_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    d.mon_plan_id,
    d.configuration,
    ee.eval_status_cd,
    esc.eval_status_cd_description,
    ee.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_cd_description,
    esa.userid,
    esa.update_date AS update_date,
    esa.window_status AS window_status,
    rpt.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
	 JOIN (
		SELECT mon_plan_id, string_agg(unit_stack, ', ') AS configuration
		FROM (
			SELECT mon_plan_id, COALESCE(unitid, stack_name) AS unit_stack
			FROM camdecmpswks.monitor_plan_location mpl
			JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
			LEFT JOIN camdecmpswks.stack_pipe USING(stack_pipe_id)
			LEFT JOIN camd.unit USING(unit_id)
			ORDER BY mon_plan_id, unitid, stack_name
		) AS d1
		GROUP BY mon_plan_id
	 ) AS d USING(mon_plan_id)
     JOIN camdecmpswks.emission_evaluation ee USING(mon_plan_id)
     JOIN camdecmpsmd.reporting_period rpt ON ee.rpt_period_id = rpt.rpt_period_id
     JOIN camdecmpsmd.eval_status_code esc ON esc.eval_status_cd::text = ee.eval_status_cd::text
     LEFT JOIN camdecmpsmd.submission_availability_code sac ON sac.submission_availability_cd::text = ee.submission_availability_cd::text
     LEFT JOIN (
      SELECT DISTINCT ON (esa.mon_plan_id, esa.rpt_period_id)
        esa.mon_plan_id,
        esa.rpt_period_id,
        esa.userid,
        COALESCE(esa.update_date, esa.add_date) AS update_date,
        esa.sub_availability_cd AS window_status
      FROM camdecmpsaux.em_submission_access esa
      WHERE esa.em_status_cd::text <> 'RECVD'::text
      ORDER BY esa.mon_plan_id, esa.rpt_period_id, esa.access_begin_date DESC
	) esa ON ee.mon_plan_id::text = esa.mon_plan_id::text AND ee.rpt_period_id = esa.rpt_period_id
	ORDER BY p.oris_code, configuration, rpt.period_abbreviation;
