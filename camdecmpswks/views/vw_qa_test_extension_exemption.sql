CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_extension_exemption (test_extension_exemption_id, mon_loc_id, mon_sys_id, component_id, span_scale_cd, extens_exempt_cd, fuel_cd, hours_used, calendar_year, quarter, rpt_period_id, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, fac_id, location_identifier, component_type_cd, component_identifier, acq_cd, system_identifier, sys_type_cd, sys_designation_cd, severity_cd, must_submit, period_begin_date, period_end_date) AS
SELECT
    ts.test_extension_exemption_id, ts.mon_loc_id, ts.mon_sys_id, ts.component_id, ts.span_scale_cd, ts.extens_exempt_cd, ts.fuel_cd, ts.hours_used, rp.calendar_year, rp.quarter, ts.rpt_period_id, ts.last_updated, ts.updated_status_flg, ts.needs_eval_flg, ts.chk_session_id, ts.userid, ts.add_date, ts.update_date, ml.fac_id, COALESCE(ml.stack_name, ml.unitid) AS location_identifier, c.component_type_cd, c.component_identifier, c.acq_cd, ms.system_identifier, ms.sys_type_cd, ms.sys_designation_cd, cs.severity_cd,
    CASE
        WHEN ts.submission_availability_cd = 'REQUIRE' OR ts.updated_status_flg = 'Y' THEN 'Y'
        ELSE 'N'
    END AS must_submit, rp.begin_date AS period_begin_date, rp.end_date AS period_end_date
    FROM camdecmpswks.test_extension_exemption AS ts
    LEFT OUTER JOIN camdecmpswks.vw_monitor_location AS ml
        ON ts.mon_loc_id = ml.mon_loc_id
    LEFT OUTER JOIN camdecmpswks.monitor_system AS ms
        ON ts.mon_sys_id = ms.mon_sys_id
    LEFT OUTER JOIN camdecmpswks.component AS c
        ON ts.component_id = c.component_id
    LEFT OUTER JOIN camdecmpsmd.reporting_period AS rp
        ON ts.rpt_period_id = rp.rpt_period_id
    LEFT OUTER JOIN camdecmpswks.check_session AS cs
        ON ts.chk_session_id = cs.chk_session_id;