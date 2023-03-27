-- View: camdecmpswks.vw_qa_supp_data_hourly_status

DROP VIEW IF EXISTS camdecmpswks.vw_qa_supp_data_hourly_status;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_supp_data_hourly_status
 AS
 SELECT qas.qa_supp_data_id,
    ts.test_sum_id,
    qas.mon_loc_id,
    qas.mon_sys_id,
    qas.component_id,
    qas.test_num,
    qas.gp_ind,
    qas.test_type_cd,
    qas.test_reason_cd,
    qas.test_result_cd,
    ts.calc_test_result_cd,
    qas.rpt_period_id,
    qas.calendar_year,
    qas.quarter,
    qas.op_level_cd,
    qas.span_scale AS span_scale_cd,
    qas.begin_date,
    qas.begin_hour,
    qas.begin_min,
    camdecmpswks.format_date_time(qas.begin_date, qas.begin_hour::integer::numeric, 0::numeric) AS begin_datehour,
    COALESCE(qas.end_date, rp.quarter_end_date) AS end_date,
    qas.end_hour,
    qas.end_min,
    camdecmpswks.format_date_time(COALESCE(qas.end_date, rp.quarter_end_date), qas.end_hour, 0::numeric) AS end_datehour,
    camdecmpswks.format_date_time(COALESCE(qas.end_date, rp.quarter_end_date), qas.end_hour, qas.end_min) AS end_datetime,
    qas.reinstallation_date,
    qas.reinstallation_hour,
    qas.reinstall_date,
    qas.reinstall_hour,
    qas.fac_id,
    qas.location_identifier,
    qas.component_type_cd,
    qas.component_identifier,
    qas.system_identifier,
    qas.sys_type_cd,
    qas.sys_designation_cd,
    qas.can_submit,
    qas.fuel_cd,
    qas.fuel_group_cd,
    qas.unit_fuel_cd,
    qas.fuel_cd_description,
    qas.operating_condition_cd,
    qas.op_condition_cd_description,
    NULL::timestamp without time zone AS test_exp_date,
    NULL::timestamp without time zone AS test_exp_date_with_ext,
    ts.needs_eval_flg,
    'N'::text AS qa_needs_eval_flg,
    'QASUPP'::text AS qa_supp_or_test_summary,
    qsa_freq.attribute_value AS rata_frequency_cd,
    qsa_baf.attribute_value AS overall_bias_adj_factor,
    qsa_level.attribute_value AS op_level_cd_list,
    qsa_claim.attribute_value AS test_claim_cd,
    cs.severity_cd,
    qas.must_submit,
    COALESCE(ts.updated_status_flg, 'N'::character varying) AS updated_status_flg,
    0 AS ignore_grace_for_extensions
   FROM camdecmpswks.vw_qa_supp_data qas
     LEFT JOIN camdecmpswks.test_summary ts ON qas.test_sum_id::text = ts.test_sum_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('RATA_FREQUENCY_CD'::text)) qsa_freq ON qas.qa_supp_data_id::text = qsa_freq.qa_supp_data_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('OVERALL_BIAS_ADJ_FACTOR'::text)) qsa_baf ON qas.qa_supp_data_id::text = qsa_baf.qa_supp_data_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('OP_LEVEL_CD_LIST'::text)) qsa_level ON qas.qa_supp_data_id::text = qsa_level.qa_supp_data_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('TEST_CLAIM_CD'::text)) qsa_claim ON qas.qa_supp_data_id::text = qsa_claim.qa_supp_data_id::text
     LEFT JOIN camdecmpswks.check_session cs ON ts.chk_session_id::text = cs.chk_session_id::text
     LEFT JOIN camdecmpsmd.vw_reporting_period rp ON qas.rpt_period_id = rp.rpt_period_id
  WHERE ts.test_sum_id IS NULL OR lower(qas.can_submit) = lower('N'::text) OR ts.needs_eval_flg::text = 'N'::text
UNION
 SELECT NULL::character varying AS qa_supp_data_id,
    ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.component_id,
    ts.test_num,
    ts.gp_ind,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.calc_test_result_cd,
    ts.rpt_period_id,
    ts.calendar_year,
    ts.quarter,
    ts.op_level_cd,
    ts.span_scale_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    camdecmpswks.format_date_time(ts.begin_date, ts.begin_hour::integer::numeric, 0::numeric) AS begin_datehour,
    COALESCE(ts.end_date, rp.quarter_end_date) AS end_date,
    ts.end_hour,
    ts.end_min,
    camdecmpswks.format_date_time(COALESCE(ts.end_date, rp.quarter_end_date), ts.end_hour, 0::numeric) AS end_datehour,
    camdecmpswks.format_date_time(COALESCE(qas.end_date, rp.quarter_end_date), ts.end_hour, ts.end_min) AS end_datetime,
    ts.reinstall_date AS reinstallation_date,
    ts.reinstall_hour AS reinstallation_hour,
    ts.reinstall_date,
    ts.reinstall_hour,
    ts.fac_id,
    ts.location_identifier,
    ts.component_type_cd,
    ts.component_identifier,
    ts.system_identifier,
    ts.sys_type_cd,
    ts.sys_designation_cd,
    'Y'::text AS can_submit,
    ts.fuel_cd,
    ts.fuel_group_cd,
    ts.unit_fuel_cd,
    ts.fuel_cd_description,
    ts.operating_condition_cd,
    ts.op_condition_cd_description,
    NULL::timestamp without time zone AS test_exp_date,
    NULL::timestamp without time zone AS test_exp_date_with_ext,
    ts.needs_eval_flg,
    'Y'::text AS qa_needs_eval_flg,
    'TESTSUM'::text AS qa_supp_or_test_summary,
    NULL::character varying AS rata_frequency_cd,
    NULL::character varying AS overall_bias_adj_factor,
    qsa_level.attribute_value AS op_level_cd_list,
    NULL::character varying AS test_claim_cd,
    cs.severity_cd,
    COALESCE(qas.must_submit, 'Y'::text) AS must_submit,
    ts.updated_status_flg,
    0 AS ignore_grace_for_extensions
   FROM camdecmpswks.vw_qa_test_summary ts
     LEFT JOIN camdecmpswks.vw_qa_supp_data qas ON ts.test_sum_id::text = qas.test_sum_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('OP_LEVEL_CD_LIST'::text)) qsa_level ON qas.qa_supp_data_id::text = qsa_level.qa_supp_data_id::text
     LEFT JOIN camdecmpswks.check_session cs ON ts.chk_session_id::text = cs.chk_session_id::text
     LEFT JOIN camdecmpsmd.vw_reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
  WHERE qas.test_sum_id IS NULL OR lower(qas.can_submit) = lower('Y'::text) AND ts.needs_eval_flg::text = 'Y'::text;
