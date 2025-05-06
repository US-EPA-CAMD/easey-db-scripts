-- View: camdecmpswks.vw_qa_cert_event_eval_and_submit

DROP VIEW IF EXISTS camdecmpswks.vw_qa_cert_event_eval_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_cert_event_eval_and_submit
 AS
 WITH submission_ord AS (
    SELECT  
        ss.submission_set_id, 
        sq.submission_id,
        ss.mon_plan_id,
        sq.test_sum_id,
        sq.qa_cert_event_id,
        sq.test_extension_exemption_id,
        sq.rpt_period_id,
        ROW_NUMBER() OVER (ORDER BY ss.queued_time) AS submission_queue_position 
    FROM camdecmpsaux.submission_set ss 
    JOIN camdecmpsaux.submission_queue sq
        ON sq.submission_set_id = ss.submission_set_id 
        AND sq.status_cd = 'QUEUED'
    LEFT JOIN camdecmpswks.MONITOR_PLAN pln
        ON pln.mon_plan_id = ss.mon_plan_id 
    LEFT JOIN camdecmpswks.TEST_SUMMARY tst
        ON tst.test_sum_id = sq.test_sum_id
    LEFT JOIN camdecmpswks.QA_CERT_EVENT qce
        ON qce.qa_cert_event_id = sq.qa_cert_event_id
    LEFT JOIN camdecmpswks.TEST_EXTENSION_EXEMPTION tee
        ON tee.test_extension_exemption_id = sq.test_extension_exemption_id
    LEFT JOIN camdecmpswks.EMISSION_EVALUATION ems
        ON ems.mon_plan_id = ss.mon_plan_id
        AND ems.rpt_period_id = sq.rpt_period_id
    WHERE (
        sq.process_cd = 'MP' AND pln.submission_availability_cd = 'PENDING'
        OR
        sq.process_cd = 'QA' AND sq.qa_cert_event_id IS NOT NULL AND qce.submission_availability_cd = 'PENDING'
        OR
        sq.process_cd = 'QA' AND sq.test_extension_exemption_id IS NOT NULL AND tee.submission_availability_cd = 'PENDING'
        OR
        sq.process_cd = 'EM' AND ems.submission_availability_cd = 'PENDING'
    )
),
 evaluation_ord AS (
  SELECT 
    evs.evaluation_set_id, 
    evq.evaluation_id, 
    evs.mon_plan_id, 
    evq.test_sum_id, 
    evq.qa_cert_event_id, 
    evq.test_extension_exemption_id, 
    evq.rpt_period_id, 
    ROW_NUMBER() OVER (
      ORDER BY 
        evs.queued_time
    ) AS evaluation_queue_position 
  FROM 
    camdecmpsaux.EVALUATION_SET evs 
    JOIN camdecmpsaux.EVALUATION_QUEUE evq ON evq.evaluation_set_id = evs.evaluation_set_id 
    AND evq.status_cd = 'QUEUED' 
    LEFT JOIN camdecmpswks.MONITOR_PLAN pln ON pln.mon_plan_id = evs.mon_plan_id 
    LEFT JOIN camdecmpswks.TEST_SUMMARY tst ON tst.test_sum_id = evq.test_sum_id 
    LEFT JOIN camdecmpswks.QA_CERT_EVENT qce ON qce.qa_cert_event_id = evq.qa_cert_event_id 
    LEFT JOIN camdecmpswks.TEST_EXTENSION_EXEMPTION tee ON tee.test_extension_exemption_id = evq.test_extension_exemption_id 
    LEFT JOIN camdecmpswks.EMISSION_EVALUATION ems ON ems.mon_plan_id = evs.mon_plan_id 
    AND ems.rpt_period_id = evq.rpt_period_id 
  WHERE 
    (
      evq.process_cd = 'MP' 
      AND pln.eval_status_cd = 'INQ' 
      OR evq.process_cd = 'QA' 
      AND evq.test_sum_id IS NOT NULL 
      AND tst.eval_status_cd = 'INQ' 
      OR evq.process_cd = 'QA' 
      AND evq.qa_cert_event_id IS NOT NULL 
      AND qce.eval_status_cd = 'INQ' 
      OR evq.process_cd = 'QA' 
      AND evq.test_extension_exemption_id IS NOT NULL 
      AND tee.eval_status_cd = 'INQ' 
      OR evq.process_cd = 'EM' 
      AND ems.eval_status_cd = 'INQ'
    )
) 
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
    COALESCE(qce.update_date, qce.add_date) AS update_date,
    qce.eval_status_cd,
    CASE WHEN qce.eval_status_cd = 'INQ' THEN COALESCE(
    'In Queue (#' || (
      SELECT 
        MIN(evaluation_queue_position) 
      FROM 
        evaluation_ord 
      WHERE 
        evaluation_ord.qa_cert_event_id = qce.qa_cert_event_id
    ):: TEXT || ' in queue)', 
    esc.eval_status_cd_description
  ) ELSE esc.eval_status_cd_description END AS eval_status_cd_description, 
    qce.submission_availability_cd,
    CASE 
        WHEN qce.submission_availability_cd = 'PENDING' THEN 
            COALESCE(
                'Submitted, Host Update Pending (#' || (
                    SELECT MIN(submission_queue_position) 
                    FROM submission_ord 
                    WHERE submission_ord.qa_cert_event_id = qce.qa_cert_event_id
                )::TEXT || ' in queue)', 
                sac.sub_avail_cd_description
            )
        ELSE sac.sub_avail_cd_description 
    END AS submission_availability_cd_description
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
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, mp.mon_plan_id, u.unitid, sp.stack_name, qce.qa_cert_event_date, qce.qa_cert_event_hour;
