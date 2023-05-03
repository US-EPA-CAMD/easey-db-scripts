-- View: camdecmpswks.vw_em_eval_and_submit

DROP VIEW IF EXISTS camdecmpswks.vw_em_eval_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_em_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS configuration,
    ee.eval_status_cd,
    esc.eval_status_cd_description,
    ee.submission_availability_cd,
    sac.sub_avail_cd_description as submission_availability_cd_description,
    esa.userid,
    COALESCE(esa.update_date, esa.add_date) AS update_date,
    esa.sub_availability_cd AS window_status,
    rpt.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.emission_evaluation ee USING (mon_plan_id)
     JOIN camdecmpsmd.reporting_period rpt
	 	ON ee.rpt_period_id = rpt.rpt_period_id
     JOIN camdecmpsmd.eval_status_code esc
	 	ON esc.eval_status_cd = ee.eval_status_cd
	 JOIN camdecmpsmd.submission_availability_code sac
	 	ON sac.submission_availability_cd = ee.submission_availability_cd
	 LEFT JOIN camdecmpsaux.em_submission_access esa
	 	ON ee.mon_plan_id::text = esa.mon_plan_id::text AND ee.rpt_period_id = esa.rpt_period_id AND esa.em_status_cd::text <> 'RECVD'::text
	 LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, p.facility_name, mp.mon_plan_id;


--REMOVE ONCE WE CHANGE THE API TO USE THE ABOVE
-- View: camdecmpswks.vw_em_review_and_submit

DROP VIEW IF EXISTS camdecmpswks.vw_em_review_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_em_review_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS configuration,
    ee.eval_status_cd,
    esc.eval_status_cd_description,
    ee.submission_availability_cd,
    sac.sub_avail_cd_description as submission_availability_cd_description,
    esa.userid,
    COALESCE(esa.update_date, esa.add_date) AS update_date,
    esa.sub_availability_cd AS window_status,
    rpt.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.emission_evaluation ee USING (mon_plan_id)
     JOIN camdecmpsmd.reporting_period rpt
	 	ON ee.rpt_period_id = rpt.rpt_period_id
     JOIN camdecmpsmd.eval_status_code esc
	 	ON esc.eval_status_cd = ee.eval_status_cd
	 JOIN camdecmpsmd.submission_availability_code sac
	 	ON sac.submission_availability_cd = ee.submission_availability_cd
	 LEFT JOIN camdecmpsaux.em_submission_access esa
	 	ON ee.mon_plan_id::text = esa.mon_plan_id::text AND ee.rpt_period_id = esa.rpt_period_id AND esa.em_status_cd::text <> 'RECVD'::text
	 LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, p.facility_name, mp.mon_plan_id;
