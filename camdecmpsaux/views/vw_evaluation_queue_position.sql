DROP VIEW IF EXISTS camdecmpsaux.vw_evaluation_queue_position;

CREATE OR REPLACE VIEW camdecmpsaux.vw_evaluation_queue_position AS
SELECT
        evs.evaluation_set_id,
        evq.evaluation_id,
        evs.mon_plan_id,
        evq.test_sum_id,
        evq.qa_cert_event_id,
        evq.test_extension_exemption_id,
        prd.period_abbreviation,
        evq.process_cd,
        evs.oris_code,
        ROW_NUMBER() OVER (ORDER BY evs.queued_time, evq.evaluation_id) as "queuePosition"
      FROM
        camdecmpsaux.evaluation_set evs
      JOIN camdecmpsaux.evaluation_queue evq
        ON evq.evaluation_set_id = evs.evaluation_set_id
        AND evq.status_cd IN ('QUEUED', 'CLAIMED')
      LEFT JOIN camdecmpswks.monitor_plan pln
        ON pln.mon_plan_id = evs.mon_plan_id
      LEFT JOIN camdecmpswks.test_summary tst
        ON tst.test_sum_id = evq.test_sum_id
      LEFT JOIN camdecmpswks.qa_cert_event qce
        ON qce.qa_cert_event_id = evq.qa_cert_event_id
      LEFT JOIN camdecmpswks.test_extension_exemption tee
        ON tee.test_extension_exemption_id = evq.test_extension_exemption_id
      LEFT JOIN camdecmpswks.emission_evaluation ems
        ON ems.mon_plan_id = evs.mon_plan_id
        AND ems.rpt_period_id = evq.rpt_period_id
      LEFT JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = ems.rpt_period_id
