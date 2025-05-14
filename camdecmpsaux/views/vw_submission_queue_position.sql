DROP VIEW IF EXISTS camdecmpsaux.vw_submission_queue_position;

CREATE OR REPLACE VIEW camdecmpsaux.vw_submission_queue_position AS
SELECT
        ss.submission_set_id,
        sq.submission_id,
        ss.mon_plan_id,
        sq.test_sum_id,
        sq.qa_cert_event_id,
        sq.test_extension_exemption_id,
        prd.period_abbreviation,
        sq.process_cd,
        ss.oris_code,
        ROW_NUMBER() OVER (
          ORDER BY ss.queued_time, sq.submission_id
        ) as "queuePosition"
      FROM
        camdecmpsaux.submission_set ss
      JOIN camdecmpsaux.submission_queue sq
        ON sq.submission_set_id = ss.submission_set_id
        AND sq.status_cd = 'QUEUED'
      LEFT JOIN camdecmpswks.monitor_plan pln
        ON pln.mon_plan_id = ss.mon_plan_id
      LEFT JOIN camdecmpswks.test_summary tst
        ON tst.test_sum_id = sq.test_sum_id
      LEFT JOIN camdecmpswks.qa_cert_event qce
        ON qce.qa_cert_event_id = sq.qa_cert_event_id
      LEFT JOIN camdecmpswks.test_extension_exemption tee
        ON tee.test_extension_exemption_id = sq.test_extension_exemption_id
      LEFT JOIN camdecmpswks.emission_evaluation ems
        ON ems.mon_plan_id = ss.mon_plan_id
        AND ems.rpt_period_id = sq.rpt_period_id
      LEFT JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = ems.rpt_period_id