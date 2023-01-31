CREATE OR REPLACE VIEW camdecmpswks.vw_qa_cert_event_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
        CASE
            WHEN u.unitid IS NOT NULL THEN u.unitid
            ELSE sp.stack_name
        END AS location_info,
    qce.qa_cert_event_id,
    qce.qa_cert_event_cd,
    qce.mon_loc_id,
        CASE
            WHEN qce.mon_sys_id IS NOT NULL THEN ms.system_identifier
            ELSE com.component_identifier
        END AS system_component_identifier,
    qsd.rpt_period_id,
        CASE
            WHEN qce.qa_cert_event_date IS NULL THEN 'N/A'::text
            ELSE concat(qce.qa_cert_event_date, ' ', lpad(qce.qa_cert_event_hour::text, 2, '0'::text))
        END AS event_date,
        CASE
            WHEN qce.conditional_data_begin_date IS NULL THEN 'N/A'::text
            ELSE concat(qce.conditional_data_begin_date, ' ', lpad(qce.conditional_data_begin_hour::text, 2, '0'::text))
        END AS condition_date,
        CASE
            WHEN qce.last_test_completed_date IS NULL THEN 'N/A'::text
            ELSE concat(qce.last_test_completed_date, ' ', lpad(qce.last_test_completed_hour::text, 2, '0'::text))
        END AS last_completion,
    qce.required_test_cd,
    qce.userid,
    qce.update_date,
    qce.eval_status_cd,
    qce.submission_availability_cd,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.qa_cert_event qce USING (mon_loc_id)
     LEFT JOIN camdecmpswks.monitor_system ms USING (mon_sys_id)
     LEFT JOIN camdecmpswks.component com USING (component_id)
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data qsd USING (qa_cert_event_id)
     LEFT JOIN camdecmpswks.component c USING (component_id)
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = qsd.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, p.facility_name, mp.mon_plan_id;