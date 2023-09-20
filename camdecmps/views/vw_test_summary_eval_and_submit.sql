-- View: camdecmpswks.vw_test_summary_eval_and_submit

DROP VIEW IF EXISTS camdecmpswks.vw_test_summary_eval_and_submit;

CREATE OR REPLACE VIEW camdecmps.vw_test_summary_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    ts.test_sum_id,
    ts.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
    ts.test_num,
    ts.gp_ind,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    qsd.rpt_period_id,
        CASE
            WHEN ts.begin_date IS NULL THEN NULL::text
            ELSE concat(ts.begin_date, ' ', lpad(COALESCE(ts.begin_hour, 0::numeric)::text, 2, '0'::text), ':', lpad(COALESCE(ts.begin_min, 0::numeric)::text, 2, '0'::text))
        END AS begin_date,
        CASE
            WHEN ts.end_date IS NULL THEN NULL::text
            ELSE concat(ts.end_date, ' ', lpad(COALESCE(ts.end_hour, 0::numeric)::text, 2, '0'::text), ':', lpad(COALESCE(ts.end_min, 0::numeric)::text, 2, '0'::text))
        END AS end_date,
    ts.updated_status_flg,
    ts.userid,
    ts.add_date,
    COALESCE(ts.update_date, ts.add_date) AS update_date,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmps.monitor_plan mp USING (fac_id)
     JOIN camdecmps.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmps.monitor_location ml USING (mon_loc_id)
     JOIN camdecmps.test_summary ts USING (mon_loc_id)
     LEFT JOIN camdecmps.qa_supp_data qsd USING (test_sum_id)
	 LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = ts.mon_sys_id::text
     LEFT JOIN camdecmps.component c ON c.component_id::text = ts.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = ts.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, mp.mon_plan_id, u.unitid, sp.stack_name, ts.test_type_cd, qsd.rpt_period_id, ts.end_date, ts.end_hour, ts.end_min;
