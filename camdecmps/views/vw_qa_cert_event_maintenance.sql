-- View: camdecmps.vw_qa_cert_event_maintenance

DROP VIEW IF EXISTS camdecmps.vw_qa_cert_event_maintenance;

CREATE OR REPLACE VIEW camdecmps.vw_qa_cert_event_maintenance
AS SELECT qce.qa_cert_event_id AS cert_event_id,
    qce.mon_loc_id AS location_id,
    COALESCE(up.oris_code, spp.oris_code) AS oris_code,
    COALESCE(u.unitid, sp.stack_name) AS unit_stack,
    ms.system_identifier,
    c.component_identifier,
    cec.qa_cert_event_cd AS cert_event_cd,
    cec.qa_cert_event_cd_description AS cert_event_description,
    camdecmps.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, 0::numeric) AS event_date_time,
    rtc.required_test_cd,
    rtc.required_test_cd_description AS required_test_description,
    camdecmps.format_date_hour(qce.conditional_data_begin_date, qce.conditional_data_begin_hour, 0::numeric) AS conditional_date_time,
    camdecmps.format_date_hour(qce.last_test_completed_date, qce.last_test_completed_hour, 0::numeric) AS last_completed_date_time,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_description,
    sc.severity_cd,
    sc.severity_cd_description AS severity_description
   FROM camdecmps.qa_cert_event qce
     JOIN camdecmps.monitor_location ml ON ml.mon_loc_id::text = qce.mon_loc_id::text
     JOIN camdecmpsmd.submission_availability_code sac USING (submission_availability_cd)
     JOIN camdecmpsmd.qa_cert_event_code cec USING (qa_cert_event_cd)
     JOIN camdecmpsmd.required_test_code rtc USING (required_test_cd)
     LEFT JOIN camdecmpsaux.check_session cs ON cs.chk_session_id::text = qce.chk_session_id::text
     LEFT JOIN camdecmpsmd.severity_code sc USING (severity_cd)
     LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = qce.mon_sys_id::text
     LEFT JOIN camdecmps.component c ON c.component_id::text = qce.component_id::text
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camd.plant up ON up.fac_id = u.fac_id
     LEFT JOIN camd.plant spp ON spp.fac_id = sp.fac_id;