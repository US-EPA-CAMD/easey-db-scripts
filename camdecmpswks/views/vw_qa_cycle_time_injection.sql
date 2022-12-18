-- View: camdecmpswks.vw_qa_cycle_time_injection

DROP VIEW IF EXISTS camdecmpswks.vw_qa_cycle_time_injection;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_cycle_time_injection
 AS
 SELECT ci.cycle_time_inj_id,
    ci.begin_date,
    ci.begin_hour,
    ci.begin_min,
    ci.cal_gas_value,
    ci.begin_monitor_value,
    ci.end_monitor_value,
    ci.injection_cycle_time,
    ci.userid,
    ci.add_date,
    ci.update_date,
    ts.test_num,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date AS test_begin_date,
    ts.begin_hour AS test_begin_hour,
    ts.begin_min AS test_begin_min,
    ts.end_date AS test_end_date,
    ts.end_hour AS test_end_hour,
    ts.end_min AS test_end_min,
    ts.total_time,
    ts.span_scale_cd,
    ts.component_type_cd,
    ts.component_identifier,
    ci.end_date,
    ci.end_hour,
    ci.end_min,
    ci.gas_level_cd,
    ts.cycle_time_sum_id,
    ts.test_sum_id,
    ts.component_id,
    ts.mon_loc_id
   FROM camdecmpswks.cycle_time_injection ci
     JOIN camdecmpswks.vw_qa_test_summary_cycle ts ON ci.cycle_time_sum_id::text = ts.cycle_time_sum_id::text;
