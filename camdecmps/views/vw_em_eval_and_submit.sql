CREATE OR REPLACE VIEW camdecmps.vw_em_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    d.mon_plan_id,
    d.configuration,
    esa.userid,
    COALESCE(esa.update_date, esa.add_date) AS update_date,
    esa.sub_availability_cd AS window_status,
    rpt.period_abbreviation
   FROM camd.plant p
     JOIN camdecmps.monitor_plan mp USING (fac_id)
	 JOIN (
		SELECT mon_plan_id, string_agg(unit_stack, ', ') AS configuration
		FROM (
			SELECT mon_plan_id, COALESCE(unitid, stack_name) AS unit_stack
			FROM camdecmps.monitor_plan_location mpl
			JOIN camdecmps.monitor_location ml USING(mon_loc_id)
			LEFT JOIN camdecmps.stack_pipe USING(stack_pipe_id)
			LEFT JOIN camd.unit USING(unit_id)
			ORDER BY mon_plan_id, unitid, stack_name
		) AS d1
		GROUP BY mon_plan_id
	 ) AS d USING(mon_plan_id)
     JOIN camdecmps.emission_evaluation ee USING(mon_plan_id)
     JOIN camdecmpsmd.reporting_period rpt ON ee.rpt_period_id = rpt.rpt_period_id
     LEFT JOIN camdecmpsaux.em_submission_access esa ON ee.mon_plan_id::text = esa.mon_plan_id::text AND ee.rpt_period_id = esa.rpt_period_id AND esa.em_status_cd::text <> 'RECVD'::text
	ORDER BY p.oris_code, configuration, rpt.period_abbreviation;
