-- View: camdecmpswks.vw_qa_test_claim

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_claim;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_claim
 AS
 SELECT ts.test_num,
    ts.gp_ind,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.sys_type_cd,
    ts.system_identifier,
    ts.mon_sys_id,
    ts.mon_loc_id,
    r.num_load_level,
    tq.test_claim_cd,
    tq.begin_date AS claim_begin_date,
    tq.end_date AS claim_end_date,
    tq.hi_load_pct,
    tq.mid_load_pct,
    tq.low_load_pct,
    tq.test_qualification_id,
    tq.test_sum_id,
    tq.userid,
    tq.add_date,
    tq.update_date
   FROM camdecmpswks.test_qualification tq
     JOIN camdecmpswks.vw_qa_test_summary ts ON tq.test_sum_id::text = ts.test_sum_id::text
     LEFT JOIN camdecmpswks.rata r ON ts.test_sum_id::text = r.test_sum_id::text;
