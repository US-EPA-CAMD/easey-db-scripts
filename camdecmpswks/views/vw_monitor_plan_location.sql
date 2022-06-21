-- View: camdecmpswks.vw_monitor_plan_location

-- DROP VIEW camdecmpswks.vw_monitor_plan_location;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_plan_location
 AS
 SELECT mpl.mon_loc_id,
    ml.stack_pipe_id,
    ml.unit_id,
    mp.mon_plan_id,
    mp.fac_id,
    sp.stack_name,
    u.unitid,
    u.non_load_based_ind,
    sp.active_date,
    sp.retire_date,
    mp.needs_eval_flg,
    cs.severity_cd,
        CASE
            WHEN mp.submission_availability_cd::text = 'REQUIRE'::text OR mp.updated_status_flg::text = 'Y'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit,
    mp.begin_rpt_period_id,
    rpbegin.calendar_year AS begin_year,
    rpbegin.quarter AS begin_quarter,
    mp.end_rpt_period_id,
    rpend.calendar_year AS end_year,
    rpend.quarter AS end_quarter
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     LEFT JOIN camdecmpsmd.vw_reporting_period rpbegin ON mp.begin_rpt_period_id = rpbegin.rpt_period_id
     LEFT JOIN camdecmpsmd.vw_reporting_period rpend ON mp.end_rpt_period_id = rpend.rpt_period_id
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
     LEFT JOIN camdecmpsaux.check_session cs ON mp.chk_session_id::text = cs.chk_session_id::text;
