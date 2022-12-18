-- View: camdecmpswks.vw_qa_test_summary_onoff

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_onoff;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_onoff
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.component_id,
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
    ts.test_comment,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    o.online_zero_injection_date,
    o.online_zero_injection_hour,
    o.on_off_cal_id,
    o.online_zero_measured_value,
    o.online_zero_ref_value,
    o.online_zero_cal_error,
    o.online_zero_aps_ind,
    o.offline_zero_injection_date,
    o.offline_zero_injection_hour,
    o.offline_zero_measured_value,
    o.offline_zero_ref_value,
    o.offline_zero_cal_error,
    o.offline_zero_aps_ind,
    o.upscale_gas_level_cd,
    o.online_upscale_injection_date,
    o.online_upscale_injection_hour,
    o.online_upscale_measured_value,
    o.online_upscale_ref_value,
    o.online_upscale_cal_error,
    o.online_upscale_aps_ind,
    o.offline_upscale_injection_date,
    o.offline_upscale_injection_hour,
    o.offline_upscale_measured_value,
    o.offline_upscale_ref_value,
    o.offline_upscale_cal_error,
    o.offline_upscale_aps_ind,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpswks.on_off_cal o ON ts.test_sum_id::text = o.test_sum_id::text
  WHERE ts.test_type_cd::text = 'ONOFF'::text;