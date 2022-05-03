-- View: camdecmpswks.vw_evem_emissions

-- DROP VIEW camdecmpswks.vw_evem_emissions;

CREATE OR REPLACE VIEW camdecmpswks.vw_evem_emissions
 AS
 SELECT ee.mon_plan_id,
    ee.rpt_period_id,
    rp.calendar_year,
    rp.quarter,
        CASE
            WHEN ee.updated_status_flg IS NULL THEN 'Y'::character varying
            ELSE ee.updated_status_flg
        END AS updated_status_flg,
        CASE
            WHEN ee.needs_eval_flg IS NULL THEN 'Y'::character varying
            ELSE ee.needs_eval_flg
        END AS needs_eval_flg,
    cs.severity_cd,
        CASE
            WHEN esa.sub_availability_cd::text = ANY (ARRAY['GRANTED'::character varying, 'REQUIRE'::character varying]::text[]) THEN 'Y'::text
            ELSE 'N'::text
        END AS can_submit,
    esa.sub_availability_cd AS submission_availability_cd
   FROM camdecmpswks.emission_evaluation ee
     JOIN camdecmpsmd.reporting_period rp ON ee.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpswks.check_session cs ON ee.chk_session_id::text = cs.chk_session_id::text
     LEFT JOIN camdecmpswksaux.em_submission_access esa ON ee.mon_plan_id::text = esa.mon_plan_id::text AND ee.rpt_period_id = esa.rpt_period_id
UNION
 SELECT esa.mon_plan_id,
    esa.rpt_period_id,
    rp.calendar_year,
    rp.quarter,
    'NODATA'::text AS updated_status_flg,
    NULL::character varying AS needs_eval_flg,
    NULL::character varying AS severity_cd,
        CASE
            WHEN esa.sub_availability_cd::text = ANY (ARRAY['GRANTED'::character varying, 'REQUIRE'::character varying]::text[]) THEN 'Y'::text
            ELSE 'N'::text
        END AS can_submit,
    esa.sub_availability_cd AS submission_availability_cd
   FROM camdecmpswksaux.em_submission_access esa
     JOIN camdecmpsmd.reporting_period rp ON esa.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpswks.emission_evaluation ee ON esa.mon_plan_id::text = ee.mon_plan_id::text AND esa.rpt_period_id = ee.rpt_period_id
  WHERE ee.mon_plan_id IS NULL;
