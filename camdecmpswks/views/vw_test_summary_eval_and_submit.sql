-- View: camdecmpswks.vw_qa_test_summary_review_and_submit

--DROP VIEW camdecmpswks.vw_qa_test_summary_review_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_test_summary_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    ts.test_sum_id,
    ts.mon_loc_id,
    COALESCE(ts.mon_sys_id, ts.component_id) AS test_info,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
    ts.test_num,
    ts.gp_ind,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    qsd.rpt_period_id,
        CASE
            WHEN ts.begin_date IS NULL THEN 'N/A'::text
            ELSE concat(ts.begin_date, ' ', lpad(ts.begin_hour::text, 2, '0'::text), ':', lpad(ts.begin_min::text, 2, '0'::text))
        END AS begin_date,
        CASE
            WHEN ts.end_date IS NULL THEN 'N/A'::text
            ELSE concat(ts.end_date, ' ', lpad(ts.end_hour::text, 2, '0'::text), ':', lpad(ts.end_min::text, 2, '0'::text))
        END AS end_date,
    ts.updated_status_flg,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ts.eval_status_cd,
    qsd.submission_availability_cd,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.test_summary ts USING (mon_loc_id)
     LEFT JOIN camdecmpswks.qa_supp_data qsd USING (test_sum_id)
     LEFT JOIN camdecmpswks.monitor_system ms ON ms.mon_sys_id::text = ts.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON c.component_id::text = ts.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = ts.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, p.facility_name, mp.mon_plan_id;

ALTER TABLE camdecmpswks.vw_qa_test_summary_review_and_submit
    OWNER TO "uImcwuf4K9dyaxeL";
