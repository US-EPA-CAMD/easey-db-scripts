CREATE OR REPLACE VIEW camdecmpswks.vw_qa_cert_event (qa_cert_event_id, mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, required_test_cd, qa_cert_event_date, qa_cert_event_hour, qa_cert_event_datehour, conditional_data_begin_date, conditional_data_begin_hour, conditional_data_begin_datehour, last_test_completed_date, last_test_completed_hour, last_test_completed_datehour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, fac_id, location_identifier, component_type_cd, component_identifier, acq_cd, system_identifier, sys_type_cd, sys_designation_cd, sys_begin_date, linearity_required, rata_required, rata2_required, rata3_required, ffacc_required, pei_required, linearity_cert_event, rata_cert_event, ooc_required, leak_required, max_op_days_prior_qtr, min_op_days_prior_qtr, max_op_hours_prior_qtr, min_op_hours_prior_qtr, severity_cd, must_submit, qa_cert_event_date_supp_data_exists_ind, qa_cert_event_op_day_count, conditional_begin_hour_supp_data_exists_ind, conditional_begin_op_hour_count, qa_cert_event_date_system_supp_data_exists_ind, qa_cert_event_system_op_day_count, conditional_begin_hour_system_supp_data_exists_ind, conditional_begin_system_op_hour_count) AS
SELECT
    ts.qa_cert_event_id, ts.mon_loc_id, ts.mon_sys_id, ts.component_id, ts.qa_cert_event_cd, ts.required_test_cd, ts.qa_cert_event_date, ts.qa_cert_event_hour, ts.qa_cert_event_date + (ts.qa_cert_event_hour::NUMERIC || ' HOUR')::INTERVAL AS qa_cert_event_datehour, ts.conditional_data_begin_date, ts.conditional_data_begin_hour, ts.conditional_data_begin_date + (ts.conditional_data_begin_hour::NUMERIC || ' HOUR')::INTERVAL AS conditional_data_begin_datehour, ts.last_test_completed_date, ts.last_test_completed_hour, ts.last_test_completed_date + (ts.last_test_completed_hour::NUMERIC || ' HOUR')::INTERVAL AS last_test_completed_datehour, ts.last_updated, ts.updated_status_flg, ts.needs_eval_flg, ts.chk_session_id, ts.userid, ts.add_date, ts.update_date, ml.fac_id, COALESCE(ml.stack_name, ml.unitid) AS location_identifier, c.component_type_cd, c.component_identifier, c.acq_cd, ms.system_identifier, ms.sys_type_cd, ms.sys_designation_cd, ms.begin_date AS sys_begin_date,
    CASE
        WHEN line.value2 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS linearity_required,
    CASE
        WHEN rata.value2 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS rata_required,
    CASE
        WHEN rata2.value2 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS rata2_required,
    CASE
        WHEN rata3.value2 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS rata3_required,
    CASE
        WHEN ffacc.value2 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS ffacc_required,
    CASE
        WHEN pei.value2 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS pei_required,
    CASE
        WHEN le.value1 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS linearity_cert_event,
    CASE
        WHEN re.value1 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS rata_cert_event,
    CASE
        WHEN ooc.value2 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS ooc_required,
    CASE
        WHEN leak.value2 IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS leak_required, NULL AS max_op_days_prior_qtr, NULL AS min_op_days_prior_qtr, NULL AS max_op_hours_prior_qtr, NULL AS min_op_hours_prior_qtr, cs.severity_cd,
    CASE
        WHEN ts.submission_availability_cd = 'REQUIRE' OR ts.updated_status_flg = 'Y' THEN 'Y'
        ELSE 'N'
    END AS must_submit,
    CASE
        WHEN eds.qa_cert_event_id IS NULL THEN 0
        ELSE 1
    END AS qa_cert_event_date_supp_data_exists_ind, eds.count AS qa_cert_event_op_day_count,
    CASE
        WHEN chs.qa_cert_event_id IS NULL THEN 0
        ELSE 1
    END AS conditional_begin_hour_supp_data_exists_ind, chs.count AS conditional_begin_op_hour_count,
    CASE
        WHEN ses.qa_cert_event_id IS NULL THEN 0
        ELSE 1
    END AS qa_cert_event_date_system_supp_data_exists_ind, ses.count AS qa_cert_event_system_op_day_count,
    CASE
        WHEN scs.qa_cert_event_id IS NULL THEN 0
        ELSE 1
    END AS conditional_begin_hour_system_supp_data_exists_ind, scs.count AS conditional_begin_system_op_hour_count
    FROM camdecmpswks.qa_cert_event AS ts
    LEFT OUTER JOIN camdecmpswks.vw_monitor_location AS ml
        ON ts.mon_loc_id = ml.mon_loc_id
    LEFT OUTER JOIN camdecmpswks.monitor_system AS ms
        ON ts.mon_sys_id = ms.mon_sys_id
    LEFT OUTER JOIN camdecmpswks.component AS c
        ON ts.component_id = c.component_id
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Test Type to Required Test Code' AND LOWER(ccv.value1) = LOWER('LINE')) AS line
        ON ts.required_test_cd = line.value2::VARCHAR
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Test Type to Required Test Code' AND LOWER(ccv.value1) LIKE LOWER('%RATA%')) AS rata
        ON ts.required_test_cd = rata.value2::VARCHAR
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Test Type to Required Test Code' AND LOWER(ccv.value1) = LOWER('RATA2')) AS rata2
        ON ts.required_test_cd = rata2.value2::VARCHAR
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Test Type to Required Test Code' AND LOWER(ccv.value1) = LOWER('RATA3')) AS rata3
        ON ts.required_test_cd = rata3.value2::VARCHAR
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Test Type to Required Test Code' AND LOWER(ccv.value1) LIKE LOWER('FFACC%')) AS ffacc
        ON ts.required_test_cd = ffacc.value2::VARCHAR
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Test Type to Required Test Code' AND LOWER(ccv.value1) = LOWER('PEI')) AS pei
        ON ts.required_test_cd = pei.value2::VARCHAR
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Certification Event Code to Test Type' AND (ccv.value2 IS NULL OR LOWER(ccv.value2) = LOWER('LINE'))) AS le
        ON ts.qa_cert_event_cd = le.value1::VARCHAR
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Certification Event Code to Test Type' AND (ccv.value2 IS NULL OR LOWER(ccv.value2) = LOWER('RATA'))) AS re
        ON ts.qa_cert_event_cd = re.value1::VARCHAR
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Test Type to Required Test Code' AND LOWER(ccv.value1) = LOWER('ONOFF')) AS ooc
        ON ts.required_test_cd = ooc.value2::VARCHAR
    LEFT OUTER JOIN (SELECT
        value1, value2
        FROM camdecmpsmd.cross_check_catalog_value AS ccv
        INNER JOIN camdecmpsmd.cross_check_catalog AS cc
            ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
        WHERE cc.cross_chk_catalog_name = 'Test Type to Required Test Code' AND LOWER(ccv.value1) = LOWER('LEAK')) AS leak
        ON ts.required_test_cd = leak.value2::VARCHAR
    LEFT OUTER JOIN camdecmpswks.check_session AS cs
        ON ts.chk_session_id = cs.chk_session_id
    LEFT OUTER JOIN
    /* Find QA_CERT_EVENT_DATE supplemental data if it exists */
    camdecmpswks.qa_cert_event_supp_data AS eds
        ON eds.qa_cert_event_id = ts.qa_cert_event_id AND eds.qa_cert_event_supp_date_cd = 'QCEDATE' AND eds.qa_cert_event_supp_data_cd = 'OP'
    LEFT OUTER JOIN
    /* Find CONDITIONAL_DATA_BEGIN_DATE supplemental data if it exists */
    camdecmpswks.qa_cert_event_supp_data AS chs
        ON chs.qa_cert_event_id = ts.qa_cert_event_id AND chs.qa_cert_event_supp_date_cd = 'CDBHOUR' AND chs.qa_cert_event_supp_data_cd = 'OP'
    LEFT OUTER JOIN
    /* Find QA_CERT_EVENT_DATE supplemental data if it exists */
    camdecmpswks.qa_cert_event_supp_data AS ses
        ON ses.qa_cert_event_id = ts.qa_cert_event_id AND ses.qa_cert_event_supp_date_cd = 'QCEDATE' AND ses.qa_cert_event_supp_data_cd = 'SYSOP'
    LEFT OUTER JOIN
    /* Find CONDITIONAL_DATA_BEGIN_DATE supplemental data if it exists */
    camdecmpswks.qa_cert_event_supp_data AS scs
        ON scs.qa_cert_event_id = ts.qa_cert_event_id AND scs.qa_cert_event_supp_date_cd = 'CDBHOUR' AND scs.qa_cert_event_supp_data_cd = 'SYSOP';