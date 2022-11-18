CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_review_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
        CASE
            WHEN u.unitid IS NOT NULL THEN u.unitid
            ELSE sp.stack_name
        END AS location_info,
    ts.test_sum_id,
    ts.mon_loc_id,
        CASE
            WHEN ts.mon_sys_id IS NOT NULL THEN ts.mon_sys_id
            ELSE ts.component_id
        END AS test_info,
    ts.test_num,
    ts.gp_ind,
    ts.calc_gp_ind,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.calc_test_result_cd,
    ts.rpt_period_id,
    ts.test_description,
        CASE
            WHEN ts.begin_date IS NULL THEN 'N/A'::text
            ELSE concat(ts.begin_date, ' ', lpad(ts.begin_hour::text, 2, '0'::text), ':', lpad(ts.begin_min::text, 2, '0'::text))
        END AS begin_date,
        CASE
            WHEN ts.end_date IS NULL THEN 'N/A'::text
            ELSE concat(ts.end_date, ' ', lpad(ts.end_hour::text, 2, '0'::text), ':', lpad(ts.end_min::text, 2, '0'::text))
        END AS end_date,
    ts.calc_span_value,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ts.span_scale_cd,
    ts.injection_protocol_cd,
    ts.eval_status_cd,
    mp.submission_availability_cd,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.test_summary ts USING (mon_loc_id)
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, p.facility_name, mp.mon_plan_id;

ALTER TABLE camdecmpswks.vw_qa_test_summary_review_and_submit
    OWNER TO "uImcwuf4K9dyaxeL";
