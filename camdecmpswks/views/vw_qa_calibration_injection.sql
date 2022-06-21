-- View: camdecmpswks.vw_qa_calibration_injection

-- DROP VIEW camdecmpswks.vw_qa_calibration_injection;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_calibration_injection
 AS
 SELECT ci.cal_inj_id,
    ci.online_offline_ind,
    ci.zero_injection_date,
    ci.zero_injection_hour,
    ci.zero_injection_min,
    ci.zero_measured_value,
    ci.zero_ref_value,
    ci.zero_cal_error,
    ci.zero_aps_ind,
    ci.userid,
    ci.add_date,
    ci.update_date,
    ts.test_num,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.span_scale_cd,
    ts.component_type_cd,
    ts.component_identifier,
    ci.upscale_injection_date,
    ci.upscale_injection_hour,
    ci.upscale_injection_min,
    ci.upscale_measured_value,
    ci.upscale_ref_value,
    ci.upscale_gas_level_cd,
    ci.upscale_cal_error,
    ci.upscale_aps_ind,
    ts.test_sum_id,
    ts.component_id,
    ts.mon_loc_id,
    ts.acq_cd
   FROM camdecmpswks.calibration_injection ci
     JOIN camdecmpswks.vw_qa_test_summary_7day ts ON ci.test_sum_id::text = ts.test_sum_id::text;
