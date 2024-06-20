-- View: camdecmpswks.vw_qa_cert_event

DROP VIEW IF EXISTS camdecmpswks.vw_qa_cert_event;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_cert_event
 AS
 SELECT ts.qa_cert_event_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.component_id,
    ts.qa_cert_event_cd,
    ts.required_test_cd,
    ts.qa_cert_event_date,
    ts.qa_cert_event_hour,
    ts.qa_cert_event_date + ((ts.qa_cert_event_hour || ' HOUR'::text)::interval) AS qa_cert_event_datehour,
    ts.conditional_data_begin_date,
    ts.conditional_data_begin_hour,
    ts.conditional_data_begin_date + ((ts.conditional_data_begin_hour || ' HOUR'::text)::interval) AS conditional_data_begin_datehour,
    ts.last_test_completed_date,
    ts.last_test_completed_hour,
    ts.last_test_completed_date + ((ts.last_test_completed_hour || ' HOUR'::text)::interval) AS last_test_completed_datehour,
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
    ms.begin_date AS sys_begin_date,
        CASE
            WHEN line.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS linearity_required,
        CASE
            WHEN rata.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS rata_required,
        CASE
            WHEN rata2.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS rata2_required,
        CASE
            WHEN rata3.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS rata3_required,
        CASE
            WHEN ffacc.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS ffacc_required,
        CASE
            WHEN pei.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS pei_required,
        CASE
            WHEN le.value1 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS linearity_cert_event,
        CASE
            WHEN re.value1 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS rata_cert_event,
        CASE
            WHEN ooc.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS ooc_required,
        CASE
            WHEN leak.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS leak_required,
    NULL::integer AS max_op_days_prior_qtr,
    NULL::integer AS min_op_days_prior_qtr,
    NULL::integer AS max_op_hours_prior_qtr,
    NULL::integer AS min_op_hours_prior_qtr,
    cs.severity_cd,
        CASE
            WHEN ts.submission_availability_cd::text = 'REQUIRE'::text OR ts.updated_status_flg::text = 'Y'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit,
        CASE
            WHEN eds.qa_cert_event_id IS NULL THEN 0
            ELSE 1
        END AS qa_cert_event_date_supp_data_exists_ind,
    eds.count AS qa_cert_event_op_day_count,
        CASE
            WHEN chs.qa_cert_event_id IS NULL THEN 0
            ELSE 1
        END AS conditional_begin_hour_supp_data_exists_ind,
    chs.count AS conditional_begin_op_hour_count,
        CASE
            WHEN ses.qa_cert_event_id IS NULL THEN 0
            ELSE 1
        END AS qa_cert_event_date_system_supp_data_exists_ind,
    ses.count AS qa_cert_event_system_op_day_count,
        CASE
            WHEN scs.qa_cert_event_id IS NULL THEN 0
            ELSE 1
        END AS conditional_begin_hour_system_supp_data_exists_ind,
    scs.count AS conditional_begin_system_op_hour_count
   FROM camdecmpswks.qa_cert_event ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('LINE'::text)) line ON ts.required_test_cd::text = line.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) ~~ lower('%RATA%'::text)) rata ON ts.required_test_cd::text = rata.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('RATA2'::text)) rata2 ON ts.required_test_cd::text = rata2.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('RATA3'::text)) rata3 ON ts.required_test_cd::text = rata3.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) ~~ lower('FFACC%'::text)) ffacc ON ts.required_test_cd::text = ffacc.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('PEI'::text)) pei ON ts.required_test_cd::text = pei.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Certification Event Code to Test Type'::text AND (ccv.value2 IS NULL OR lower(ccv.value2) = lower('LINE'::text))) le ON ts.qa_cert_event_cd::text = le.value1::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Certification Event Code to Test Type'::text AND (ccv.value2 IS NULL OR lower(ccv.value2) = lower('RATA'::text))) re ON ts.qa_cert_event_cd::text = re.value1::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('ONOFF'::text)) ooc ON ts.required_test_cd::text = ooc.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('LEAK'::text)) leak ON ts.required_test_cd::text = leak.value2::character varying::text
     LEFT JOIN camdecmpswks.check_session cs ON ts.chk_session_id::text = cs.chk_session_id::text
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data eds ON eds.qa_cert_event_id::text = ts.qa_cert_event_id::text AND eds.qa_cert_event_supp_date_cd::text = 'QCEDATE'::text AND eds.qa_cert_event_supp_data_cd::text = 'OP'::text
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data chs ON chs.qa_cert_event_id::text = ts.qa_cert_event_id::text AND chs.qa_cert_event_supp_date_cd::text = 'CDBHOUR'::text AND chs.qa_cert_event_supp_data_cd::text = 'OP'::text
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data ses ON ses.qa_cert_event_id::text = ts.qa_cert_event_id::text AND ses.qa_cert_event_supp_date_cd::text = 'QCEDATE'::text AND ses.qa_cert_event_supp_data_cd::text = 'SYSOP'::text
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data scs ON scs.qa_cert_event_id::text = ts.qa_cert_event_id::text AND scs.qa_cert_event_supp_date_cd::text = 'CDBHOUR'::text AND scs.qa_cert_event_supp_data_cd::text = 'SYSOP'::text;
