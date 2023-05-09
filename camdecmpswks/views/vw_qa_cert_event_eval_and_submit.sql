-- View: camdecmpswks.vw_qa_cert_event_eval_and_submit

DROP VIEW IF EXISTS camdecmpswks.vw_qa_cert_event_eval_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_cert_event_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    qce.qa_cert_event_id,
    qce.qa_cert_event_cd,
    qce.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
    qsd.rpt_period_id,
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
    COALESCE(qce.update_date, qce.add_date) AS update_date,
    qce.eval_status_cd,
    esc.eval_status_cd_description,
    qce.submission_availability_cd,
    sac.sub_avail_cd_description as submission_availability_cd_description,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.qa_cert_event qce USING (mon_loc_id)
     JOIN camdecmpsmd.eval_status_code esc
	 	ON esc.eval_status_cd = qce.eval_status_cd
	 JOIN camdecmpsmd.submission_availability_code sac
	 	ON sac.submission_availability_cd = qce.submission_availability_cd	 
     LEFT JOIN camdecmpswks.monitor_system ms USING (mon_sys_id)
     LEFT JOIN camdecmpswks.component c USING (component_id)
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data qsd USING (qa_cert_event_id)
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = qsd.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, p.facility_name, mp.mon_plan_id;
