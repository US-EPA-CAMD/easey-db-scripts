-- View: camdecmpswks.vw_qa_test_summary_line

-- DROP VIEW camdecmpswks.vw_qa_test_summary_line;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_line
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.test_type_cd,
    ts.component_id,
    ts.test_num,
    ts.gp_ind,
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
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    c.hg_converter_ind,
    ts.begin_date + ((ts.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    ts.end_date + ((ts.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
  WHERE ts.test_type_cd::text = ANY (ARRAY['LINE'::character varying, 'HGLINE'::character varying, 'HGSI3'::character varying]::text[]);

