-- View: camdecmps.vw_qa_test_summary_maintenance

DROP VIEW IF EXISTS camdecmps.vw_qa_test_summary_maintenance;

CREATE OR REPLACE VIEW camdecmps.vw_qa_test_summary_maintenance
AS SELECT ts.test_sum_id,
    ts.mon_loc_id AS location_id,
    COALESCE(up.oris_code, spp.oris_code) AS oris_code,
    COALESCE(u.unitid, sp.stack_name) AS unit_stack,
    ms.system_identifier,
    c.component_identifier,
    ts.test_num AS test_number,
    ts.gp_ind AS grace_period_indicator,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    rp.period_abbreviation AS year_quarter,
    ts.test_description,
    camdecmps.format_date_hour(ts.begin_date, ts.begin_hour, ts.begin_min) AS begin_date_time,
    camdecmps.format_date_hour(ts.end_date, ts.end_hour, ts.end_min) AS end_date_time,
    ts.test_comment,
    ts.span_scale_cd,
    ts.injection_protocol_cd,
    sd.resub_explanation,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_description,
    sc.severity_cd,
    sc.severity_cd_description AS severity_description
   FROM camdecmps.test_summary ts
     JOIN camdecmps.qa_supp_data sd USING (test_sum_id)
     JOIN camdecmps.monitor_location ml ON ml.mon_loc_id::text = ts.mon_loc_id::text
     JOIN camdecmpsmd.submission_availability_code sac USING (submission_availability_cd)
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = ts.rpt_period_id
     LEFT JOIN camdecmpsaux.check_session cs ON cs.chk_session_id::text = ts.chk_session_id::text
     LEFT JOIN camdecmpsmd.severity_code sc USING (severity_cd)
     LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = ts.mon_sys_id::text
     LEFT JOIN camdecmps.component c ON c.component_id::text = ts.component_id::text
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camd.plant up ON up.fac_id = u.fac_id
     LEFT JOIN camd.plant spp ON spp.fac_id = sp.fac_id;
