-- View: camdecmpswks.vw_test_summary_eval_and_submit

DROP VIEW IF EXISTS camdecmpswks.vw_test_summary_eval_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_test_summary_eval_and_submit
 AS
 WITH ord AS (
    SELECT  
        evs.evaluation_set_id, 
        evq.evaluation_id,
        evs.mon_plan_id,
        evq.test_sum_id,
        evq.qa_cert_event_id,
        evq.test_extension_exemption_id,
        evq.rpt_period_id,
        ROW_NUMBER() OVER (ORDER BY evs.queued_time) AS queue_position 
    FROM camdecmpsaux.EVALUATION_SET evs 
    JOIN camdecmpsaux.EVALUATION_QUEUE evq
        ON evq.evaluation_set_id = evs.evaluation_set_id 
        AND evq.status_cd = 'QUEUED'
    LEFT JOIN camdecmpswks.MONITOR_PLAN pln
        ON pln.mon_plan_id = evs.mon_plan_id 
    LEFT JOIN camdecmpswks.TEST_SUMMARY tst
        ON tst.test_sum_id = evq.test_sum_id
    LEFT JOIN camdecmpswks.QA_CERT_EVENT qce
        ON qce.qa_cert_event_id = evq.qa_cert_event_id
    LEFT JOIN camdecmpswks.TEST_EXTENSION_EXEMPTION tee
        ON tee.test_extension_exemption_id = evq.test_extension_exemption_id
    LEFT JOIN camdecmpswks.EMISSION_EVALUATION ems
        ON ems.mon_plan_id = evs.mon_plan_id
        AND ems.rpt_period_id = evq.rpt_period_id
    WHERE (
        evq.process_cd = 'MP' AND pln.eval_status_cd = 'INQ'
        OR
        evq.process_cd = 'QA' AND evq.test_sum_id IS NOT NULL AND tst.eval_status_cd = 'INQ'
        OR
        evq.process_cd = 'QA' AND evq.qa_cert_event_id IS NOT NULL AND qce.eval_status_cd = 'INQ'
        OR
        evq.process_cd = 'QA' AND evq.test_extension_exemption_id IS NOT NULL AND tee.eval_status_cd = 'INQ'
        OR
        evq.process_cd = 'EM' AND ems.eval_status_cd = 'INQ'
    )
)
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
    ts.eval_status_cd,
    CASE 
        WHEN ts.eval_status_cd = 'INQ' THEN 
            COALESCE(
                'In Queue (#' || (
                    SELECT MIN(queue_position)
                    FROM ord
                    WHERE ord.test_sum_id = ts.test_sum_id 
                )::TEXT || ' in queue)',
                esc.eval_status_cd_description
            )
        ELSE esc.eval_status_cd_description 
    END AS eval_status_cd_description,
    qsd.submission_availability_cd,
    sac.sub_avail_cd_description as submission_availability_cd_description,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.test_summary ts USING (mon_loc_id)
     JOIN camdecmpsmd.eval_status_code esc
	 	ON esc.eval_status_cd = ts.eval_status_cd
     LEFT JOIN camdecmpswks.qa_supp_data qsd USING (test_sum_id)
	 LEFT JOIN camdecmpsmd.submission_availability_code sac
	 	ON sac.submission_availability_cd = qsd.submission_availability_cd	 
	 LEFT JOIN camdecmpswks.monitor_system ms ON ms.mon_sys_id::text = ts.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON c.component_id::text = ts.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = ts.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, mp.mon_plan_id, u.unitid, sp.stack_name, ts.test_type_cd, qsd.rpt_period_id, ts.end_date, ts.end_hour, ts.end_min;
