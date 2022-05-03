-- View: camdecmpswks.vw_qa_ae_correlation_test_run

-- DROP VIEW camdecmpswks.vw_qa_ae_correlation_test_run;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_ae_correlation_test_run
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
    ts.sys_type_cd,
    ts.system_identifier,
    ts.mon_sys_id,
    ts.fuel_cd,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ts.ae_corr_test_sum_id,
    ts.op_level_num,
    ar.ae_corr_test_run_id,
    ar.run_num,
    ar.begin_date,
    ar.begin_hour,
    ar.begin_min,
    ar.end_date,
    ar.end_hour,
    ar.end_min,
    ar.response_time,
    ar.ref_value,
    ar.hourly_hi_rate,
    ar.total_hi,
    ar.userid,
    ar.add_date,
    ar.update_date
   FROM camdecmpswks.ae_correlation_test_run ar
     JOIN camdecmpswks.vw_qa_ae_correlation_test_sum ts ON ar.ae_corr_test_sum_id::text = ts.ae_corr_test_sum_id::text;
