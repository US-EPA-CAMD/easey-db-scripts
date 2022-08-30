CREATE OR REPLACE VIEW camdecmpswks.vw_qa_supp_data_hourly_status (qa_supp_data_id, test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, rpt_period_id, calendar_year, quarter, op_level_cd, span_scale_cd, begin_date, begin_hour, begin_min, begin_datehour, end_date, end_hour, end_min, end_datehour, end_datetime, reinstallation_date, reinstallation_hour, reinstall_date, reinstall_hour, fac_id, location_identifier, component_type_cd, component_identifier, system_identifier, sys_type_cd, sys_designation_cd, can_submit, fuel_cd, fuel_group_cd, unit_fuel_cd, fuel_cd_description, operating_condition_cd, op_condition_cd_description, test_exp_date, test_exp_date_with_ext, needs_eval_flg, qa_needs_eval_flg, qa_supp_or_test_summary, rata_frequency_cd, overall_bias_adj_factor, op_level_cd_list, test_claim_cd, severity_cd, must_submit, updated_status_flg, ignore_grace_for_extensions) AS
SELECT
    qas.qa_supp_data_id, ts.test_sum_id, qas.mon_loc_id, qas.mon_sys_id, qas.component_id, qas.test_num, qas.gp_ind, qas.test_type_cd, qas.test_reason_cd, qas.test_result_cd, ts.calc_test_result_cd, qas.rpt_period_id, qas.calendar_year, qas.quarter, qas.op_level_cd, qas.span_scale AS span_scale_cd, qas.begin_date, qas.begin_hour, qas.begin_min, camdecmpswks.format_date_time(qas.begin_date, qas.begin_hour::INTEGER, 0) AS begin_datehour, COALESCE(qas.end_date, rp.quarter_end_date) AS end_date, qas.end_hour, qas.end_min, camdecmpswks.format_date_time(COALESCE(qas.end_date, rp.quarter_end_date), qas.end_hour, 0) AS end_datehour, camdecmpswks.format_date_time(COALESCE(qas.end_date, rp.quarter_end_date), qas.end_hour, qas.end_min) AS end_datetime, qas.reinstallation_date, qas.reinstallation_hour, qas.reinstall_date, qas.reinstall_hour, qas.fac_id, qas.location_identifier, qas.component_type_cd, qas.component_identifier, qas.system_identifier, qas.sys_type_cd, qas.sys_designation_cd, qas.can_submit, qas.fuel_cd, qas.fuel_group_cd, qas.unit_fuel_cd, qas.fuel_cd_description, operating_condition_cd, qas.op_condition_cd_description, CAST (NULL AS TIMESTAMP WITHOUT TIME ZONE) AS test_exp_date, CAST (NULL AS TIMESTAMP WITHOUT TIME ZONE) AS test_exp_date_with_ext, ts.needs_eval_flg, 'N'::TEXT AS qa_needs_eval_flg, 'QASUPP'::TEXT AS qa_supp_or_test_summary, qsa_freq.attribute_value AS rata_frequency_cd, qsa_baf.attribute_value AS overall_bias_adj_factor, qsa_level.attribute_value AS op_level_cd_list, qsa_claim.attribute_value AS test_claim_cd, cs.severity_cd, qas.must_submit, COALESCE(ts.updated_status_flg, 'N') AS updated_status_flg, CAST (0 AS INTEGER) AS ignore_grace_for_extensions
    FROM camdecmpswks.vw_qa_supp_data AS qas
    LEFT OUTER JOIN camdecmpswks.test_summary AS ts
        ON qas.test_sum_id = ts.test_sum_id
    LEFT OUTER JOIN (SELECT
        *
        FROM camdecmpswks.qa_supp_attribute
        WHERE LOWER(attribute_name) = LOWER('RATA_FREQUENCY_CD')) AS qsa_freq
        ON qas.qa_supp_data_id = qsa_freq.qa_supp_data_id
    LEFT OUTER JOIN (SELECT
        *
        FROM camdecmpswks.qa_supp_attribute
        WHERE LOWER(attribute_name) = LOWER('OVERALL_BIAS_ADJ_FACTOR')) AS qsa_baf
        ON qas.qa_supp_data_id = qsa_baf.qa_supp_data_id
    LEFT OUTER JOIN (SELECT
        *
        FROM camdecmpswks.qa_supp_attribute
        WHERE LOWER(attribute_name) = LOWER('OP_LEVEL_CD_LIST')) AS qsa_level
        ON qas.qa_supp_data_id = qsa_level.qa_supp_data_id
    LEFT OUTER JOIN (SELECT
        *
        FROM camdecmpswks.qa_supp_attribute
        WHERE LOWER(attribute_name) = LOWER('TEST_CLAIM_CD')) AS qsa_claim
        ON qas.qa_supp_data_id = qsa_claim.qa_supp_data_id
    LEFT OUTER JOIN camdecmpswks.check_session AS cs
        ON ts.chk_session_id = cs.chk_session_id
    LEFT OUTER JOIN camdecmpsmd.vw_reporting_period AS rp
        ON qas.rpt_period_id = rp.rpt_period_id
    WHERE ts.test_sum_id IS NULL OR LOWER(qas.can_submit) = LOWER('N') OR ts.needs_eval_flg = 'N'
UNION
SELECT
    NULL AS qa_supp_data_id, ts.test_sum_id, ts.mon_loc_id, ts.mon_sys_id, ts.component_id, ts.test_num, ts.gp_ind, ts.test_type_cd, ts.test_reason_cd, ts.test_result_cd, ts.calc_test_result_cd, ts.rpt_period_id, ts.calendar_year, ts.quarter, ts.op_level_cd, ts.span_scale_cd, ts.begin_date, ts.begin_hour, ts.begin_min, camdecmpswks.format_date_time(ts.begin_date, ts.begin_hour::INTEGER, 0) AS begin_datehour, COALESCE(ts.end_date, rp.quarter_end_date) AS end_date, ts.end_hour, ts.end_min, camdecmpswks.format_date_time(COALESCE(ts.end_date, rp.quarter_end_date), ts.end_hour, 0) AS end_datehour, camdecmpswks.format_date_time(COALESCE(qas.end_date, rp.quarter_end_date), ts.end_hour, ts.end_min) AS end_datetime, ts.reinstall_date AS reinstallation_date, ts.reinstall_hour AS reinstallation_hour, ts.reinstall_date, ts.reinstall_hour, ts.fac_id, ts.location_identifier, ts.component_type_cd, ts.component_identifier, ts.system_identifier, ts.sys_type_cd, ts.sys_designation_cd, 'Y'::TEXT AS can_submit, ts.fuel_cd, ts.fuel_group_cd, ts.unit_fuel_cd, ts.fuel_cd_description, ts.operating_condition_cd, ts.op_condition_cd_description, CAST (NULL AS TIMESTAMP WITHOUT TIME ZONE) AS test_exp_date, CAST (NULL AS TIMESTAMP WITHOUT TIME ZONE) AS test_exp_date_with_ext, ts.needs_eval_flg, 'Y'::TEXT AS qa_needs_eval_flg, 'TESTSUM'::TEXT AS qa_supp_or_test_summary, NULL AS rata_frequency_cd, NULL AS overall_bias_adj_factor, qsa_level.attribute_value AS op_level_cd_list, NULL AS test_claim_cd, cs.severity_cd, COALESCE(qas.must_submit, 'Y') AS must_submit, ts.updated_status_flg, CAST (0 AS INTEGER) AS ignore_grace_for_extensions
    FROM camdecmpswks.vw_qa_test_summary AS ts
    LEFT OUTER JOIN camdecmpswks.vw_qa_supp_data AS qas
        ON ts.test_sum_id = qas.test_sum_id
    LEFT OUTER JOIN (SELECT
        *
        FROM camdecmpswks.qa_supp_attribute
        WHERE LOWER(attribute_name) = LOWER('OP_LEVEL_CD_LIST')) AS qsa_level
        ON qas.qa_supp_data_id = qsa_level.qa_supp_data_id
    LEFT OUTER JOIN camdecmpswks.check_session AS cs
        ON ts.chk_session_id = cs.chk_session_id
    LEFT OUTER JOIN camdecmpsmd.vw_reporting_period AS rp
        ON ts.rpt_period_id = rp.rpt_period_id
    WHERE qas.test_sum_id IS NULL OR (LOWER(qas.can_submit) = LOWER('Y') AND ts.needs_eval_flg = 'Y');