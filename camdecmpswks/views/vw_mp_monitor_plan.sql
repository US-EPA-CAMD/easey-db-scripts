-- View: camdecmpswks.vw_mp_monitor_plan

-- DROP VIEW camdecmpswks.vw_mp_monitor_plan;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_plan
 AS
 SELECT mp.mon_plan_id,
    f.oris_code,
    f.facility_name,
    f.state,
    mp.fac_id,
    mp.config_type_cd,
    mp.begin_rpt_period_id,
    mp.end_rpt_period_id,
    dmps.mon_plan_status_cd AS status,
    dmps.mon_plan_status_cd_description AS display_status,
    mp.last_updated,
    mp.updated_status_flg,
    mp.needs_eval_flg,
    mp.chk_session_id,
    mp.last_evaluated_date,
    mp.submission_id,
    mp.submission_availability_cd,
    f.first_ecmps_rpt_period_id,
    cs.severity_cd,
        CASE
            WHEN mp.submission_availability_cd::text = 'REQUIRE'::text OR mp.updated_status_flg::text = 'Y'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit
   FROM camdecmpswks.monitor_plan mp
     JOIN camd.plant f ON mp.fac_id = f.fac_id
     LEFT JOIN camdecmpswks.derived_monitorplanstatus() dmps(mon_plan_id, begin_date, end_date, mon_plan_status_cd, mon_plan_status_cd_description) ON mp.mon_plan_id::text = dmps.mon_plan_id
     LEFT JOIN camdecmpsmd.vw_reporting_period rpbegin ON mp.begin_rpt_period_id = rpbegin.rpt_period_id
     LEFT JOIN camdecmpsmd.vw_reporting_period rpend ON mp.end_rpt_period_id = rpend.rpt_period_id
     LEFT JOIN camdecmpswks.check_session cs ON mp.chk_session_id::text = cs.chk_session_id::text;

