-- View: camdecmpswks.vw_em_review_and_submit

DROP VIEW IF EXISTS camdecmpswks.vw_em_review_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_em_review_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
        CASE
            WHEN u.unitid IS NOT NULL THEN u.unitid
            ELSE sp.stack_name
        END AS configuration,
    ee.eval_status_cd,
    ee.submission_availability_cd,
    esa.userid,
        CASE
            WHEN esa.update_date IS NULL THEN esa.add_date
            ELSE esa.update_date
        END AS update_date,
    esa.sub_availability_cd AS window_status,
    rpt.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.emission_evaluation ee USING (mon_plan_id)
     JOIN camdecmpsmd.reporting_period rpt ON ee.rpt_period_id = rpt.rpt_period_id
     LEFT JOIN camdecmpsaux.em_submission_access esa ON ee.mon_plan_id::text = esa.mon_plan_id::text AND ee.rpt_period_id = esa.rpt_period_id AND esa.em_status_cd::text <> 'RECVD'::text
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, p.facility_name, mp.mon_plan_id;
