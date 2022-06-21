CREATE OR REPLACE  VIEW camdecmpswks.vw_qa_test_summary_hglme (test_sum_id, mon_loc_id, test_num, test_reason_cd, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, fac_id, location_identifier, hg_default_test_sum_id, test_frequency_cd, group_id, num_units_in_group, num_tests_for_group, max_operating_hours, max_potential_hg_mass, default_hg_concentration, common_stack_test_cd, cs_unit_test_ind) AS
SELECT
    ts.test_sum_id, ts.mon_loc_id, ts.test_num, ts.test_reason_cd, ts.begin_date, ts.begin_hour, ts.begin_min, ts.end_date, ts.end_hour, ts.end_min, ts.test_comment, ts.last_updated, ts.updated_status_flg, ts.needs_eval_flg, ts.chk_session_id, ts.userid, ts.add_date, ts.update_date, ml.fac_id, COALESCE(ml.stack_name, ml.unitid) AS location_identifier, hd.hg_default_test_sum_id, hd.test_frequency_cd, hd.group_id, hd.num_units_in_group, hd.num_tests_for_group, hd.max_operating_hours, hd.max_potential_hg_mass, hd.default_hg_concentration, hd.common_stack_test_cd, hd.cs_unit_test_ind
    FROM camdecmpswks.test_summary AS ts
    LEFT OUTER JOIN camdecmpswks.vw_monitor_location AS ml
        ON ts.mon_loc_id = ml.mon_loc_id
    LEFT OUTER JOIN camdecmpswks.hg_lme_default_test_summary AS hd
        ON ts.test_sum_id = hd.test_sum_id
    WHERE test_type_cd = 'HGLME';