-- View: camdecmps.vw_qa_test_extens_exempt_maintenance

DROP VIEW IF EXISTS camdecmps.vw_qa_test_extens_exempt_maintenance;

CREATE OR REPLACE VIEW camdecmps.vw_qa_test_extens_exempt_maintenance
AS SELECT tee.test_extension_exemption_id,
    tee.mon_loc_id AS location_id,
    tee.resub_explanation,
    COALESCE(up.oris_code, spp.oris_code) AS oris_code,
    COALESCE(u.unitid, sp.stack_name) AS unit_stack,
    ms.system_identifier,
    c.component_identifier,
    fc.fuel_cd,
    fc.fuel_cd_description AS fuel_description,
    eec.extens_exempt_cd AS extension_exemption_cd,
    eec.extens_exemp_cd_description AS extension_exemption_description,
    rp.period_abbreviation AS year_quarter,
    tee.hours_used,
    tee.span_scale_cd,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_description,
    sc.severity_cd,
    sc.severity_cd_description AS severity_description
   FROM camdecmps.test_extension_exemption tee
     JOIN camdecmps.monitor_location ml ON ml.mon_loc_id::text = tee.mon_loc_id::text
     JOIN camdecmpsmd.submission_availability_code sac USING (submission_availability_cd)
     JOIN camdecmpsmd.fuel_code fc USING (fuel_cd)
     JOIN camdecmpsmd.extension_exemption_code eec USING (extens_exempt_cd)
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = tee.rpt_period_id
     LEFT JOIN camdecmpsaux.check_session cs ON cs.chk_session_id::text = tee.chk_session_id::text
     LEFT JOIN camdecmpsmd.severity_code sc USING (severity_cd)
     LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = tee.mon_sys_id::text
     LEFT JOIN camdecmps.component c ON c.component_id::text = tee.component_id::text
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camd.plant up ON up.fac_id = u.fac_id
     LEFT JOIN camd.plant spp ON spp.fac_id = sp.fac_id;
