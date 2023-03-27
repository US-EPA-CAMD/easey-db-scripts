-- View: camdecmpswks.vw_qa_test_extension_exemption

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_extension_exemption;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_extension_exemption
 AS
 SELECT ts.test_extension_exemption_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.component_id,
    ts.span_scale_cd,
    ts.extens_exempt_cd,
    ts.fuel_cd,
    ts.hours_used,
    rp.calendar_year,
    rp.quarter,
    ts.rpt_period_id,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    cs.severity_cd,
        CASE
            WHEN ts.submission_availability_cd::text = 'REQUIRE'::text OR ts.updated_status_flg::text = 'Y'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit,
    rp.begin_date AS period_begin_date,
    rp.end_date AS period_end_date
   FROM camdecmpswks.test_extension_exemption ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpswks.check_session cs ON ts.chk_session_id::text = cs.chk_session_id::text;
