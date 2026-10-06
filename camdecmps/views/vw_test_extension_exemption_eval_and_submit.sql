CREATE OR REPLACE VIEW camdecmps.vw_qa_cert_event_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    qce.qa_cert_event_id,
    qce.qa_cert_event_cd,
    qce.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
        CASE
            WHEN qce.qa_cert_event_date IS NULL THEN NULL::text
            ELSE concat(qce.qa_cert_event_date, ' ', lpad(COALESCE(qce.qa_cert_event_hour, 0::numeric)::text, 2, '0'::text), ':00')
        END AS event_date,
        CASE
            WHEN qce.conditional_data_begin_date IS NULL THEN NULL::text
            ELSE concat(qce.conditional_data_begin_date, ' ', lpad(COALESCE(qce.conditional_data_begin_hour, 0::numeric)::text, 2, '0'::text), ':00')
        END AS condition_date,
        CASE
            WHEN qce.last_test_completed_date IS NULL THEN NULL::text
            ELSE concat(qce.last_test_completed_date, ' ', lpad(COALESCE(qce.last_test_completed_hour, 0::numeric)::text, 2, '0'::text), ':00')
        END AS last_completion,
    qce.required_test_cd,
    qce.userid,
    COALESCE(qce.update_date, qce.add_date) AS update_date
   FROM camd.plant p
     JOIN camdecmps.monitor_plan mp USING (fac_id)
     JOIN camdecmps.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmps.monitor_location ml USING (mon_loc_id)
     JOIN camdecmps.qa_cert_event qce USING (mon_loc_id)
     LEFT JOIN camdecmps.monitor_system ms USING (mon_sys_id)
     LEFT JOIN camdecmps.component c USING (component_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, mp.mon_plan_id, u.unitid, sp.stack_name, qce.qa_cert_event_date, qce.qa_cert_event_hour;
