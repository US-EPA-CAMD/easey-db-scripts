-- View: camdecmpswks.vw_qa_test_summary_unitdef

DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_unitdef;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_unitdef
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ud.unit_default_test_sum_id,
    ud.fuel_cd,
    ud.operating_condition_cd,
    ud.nox_default_rate,
    ud.group_id,
    ud.num_units_in_group,
    ud.num_tests_for_group
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.unit_default_test ud ON ts.test_sum_id::text = ud.test_sum_id::text
  WHERE ts.test_type_cd::text = 'UNITDEF'::text;
