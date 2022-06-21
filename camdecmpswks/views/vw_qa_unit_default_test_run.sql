-- View: camdecmpswks.vw_qa_unit_default_test_run

-- DROP VIEW camdecmpswks.vw_qa_unit_default_test_run;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_unit_default_test_run
 AS
 SELECT ts.test_sum_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date AS test_begin_date,
    ts.begin_hour AS test_begin_hour,
    ts.begin_min AS test_begin_min,
    ts.end_date AS test_end_date,
    ts.end_hour AS test_end_hour,
    ts.end_min AS test_end_min,
    ts.fuel_cd,
    ts.operating_condition_cd,
    ts.nox_default_rate,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ts.unit_default_test_sum_id,
    ur.op_level_num,
    ur.unit_default_test_run_id,
    ur.run_num,
    ur.begin_date,
    ur.begin_hour,
    ur.begin_min,
    ur.end_date,
    ur.end_hour,
    ur.end_min,
    ur.response_time,
    ur.ref_value,
    ur.run_used_ind,
    ur.userid,
    ur.add_date,
    ur.update_date
   FROM camdecmpswks.unit_default_test_run ur
     JOIN camdecmpswks.vw_qa_test_summary_unitdef ts ON ur.unit_default_test_sum_id::text = ts.unit_default_test_sum_id::text;
