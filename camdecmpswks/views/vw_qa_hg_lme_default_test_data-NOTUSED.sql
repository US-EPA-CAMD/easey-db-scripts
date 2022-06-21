CREATE OR REPLACE  VIEW camdecmpswks.vw_qa_hg_lme_default_test_data (test_num, test_reason_cd, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, hg_lme_default_test_data_id, hg_default_test_sum_id, test_sum_id, mon_loc_id, test_location_id, location_identifier, max_run_value, userid, add_date, update_date, ref_method_cd, hg_op_level_cd, cs_unit_test_ind) AS
SELECT
    ts.test_num, ts.test_reason_cd, ts.begin_date, ts.begin_hour, ts.begin_min, ts.end_date, ts.end_hour, ts.end_min, hs.hg_lme_default_test_data_id, hs.hg_default_test_sum_id, ts.test_sum_id, ts.mon_loc_id, hs.test_location_id, ts.location_identifier, hs.max_run_value, hs.userid, hs.add_date, hs.update_date, hs.ref_method_cd, hs.hg_op_level_cd, ts.cs_unit_test_ind
    FROM camdecmpswks.hg_lme_default_test_data AS hs
    INNER JOIN camdecmpswks.vw_qa_test_summary_hglme AS ts
        ON hs.hg_default_test_sum_id = ts.hg_default_test_sum_id;