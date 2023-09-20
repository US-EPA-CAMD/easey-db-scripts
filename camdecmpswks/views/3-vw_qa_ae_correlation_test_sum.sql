-- View: camdecmpswks.vw_qa_ae_correlation_test_sum

DROP VIEW IF EXISTS camdecmpswks.vw_qa_ae_correlation_test_sum;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_ae_correlation_test_sum
 AS
 SELECT ts.test_sum_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.sys_type_cd,
    ts.system_identifier,
    ts.fuel_cd,
    ts.mon_sys_id,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ac.ae_corr_test_sum_id,
    ac.op_level_num,
    ac.mean_ref_value,
    ac.avg_hrly_hi_rate,
    ac.f_factor,
    ac.userid,
    ac.add_date,
    ac.update_date
   FROM camdecmpswks.ae_correlation_test_sum ac
     JOIN camdecmpswks.vw_qa_test_summary_appe ts ON ac.test_sum_id::text = ts.test_sum_id::text;
