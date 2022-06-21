CREATE OR REPLACE  VIEW camdecmpswks.vw_qa_test_summary_gfmcal (test_sum_id, mon_loc_id, component_id, test_num, test_result_cd, test_reason_cd, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, fac_id, location_identifier, component_identifier, component_type_cd, gfm_calibration_id, num_levels, ref_calibration_y, calibration_y, percent_cal_change) AS
SELECT
    ts.test_sum_id, ts.mon_loc_id, ts.component_id, ts.test_num, ts.test_result_cd, ts.test_reason_cd, ts.begin_date, ts.begin_hour, ts.begin_min, ts.end_date, ts.end_hour, ts.end_min, ts.test_comment, ts.last_updated, ts.updated_status_flg, ts.needs_eval_flg, ts.chk_session_id, ts.userid, ts.add_date, ts.update_date, ml.fac_id, COALESCE(ml.stack_name, ml.unitid) AS location_identifier, c.component_identifier, c.component_type_cd, gc.gfm_calibration_id, gc.num_levels, gc.ref_calibration_y, gc.calibration_y, gc.percent_cal_change
    FROM camdecmpswks.test_summary AS ts
    LEFT OUTER JOIN camdecmpswks.gfm_calibration AS gc
        ON ts.test_sum_id = gc.test_sum_id
    LEFT OUTER JOIN camdecmpswks.vw_monitor_location AS ml
        ON ts.mon_loc_id = ml.mon_loc_id
    LEFT OUTER JOIN camdecmpswks.component AS c
        ON ts.component_id = c.component_id
    WHERE test_type_cd = 'GFMCAL';