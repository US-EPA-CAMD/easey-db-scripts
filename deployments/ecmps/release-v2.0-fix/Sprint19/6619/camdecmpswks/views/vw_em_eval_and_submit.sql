-- View: camdecmpswks.vw_em_eval_and_submit
DROP VIEW IF EXISTS camdecmpswks.vw_em_eval_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_em_eval_and_submit AS
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
SELECT
    fac.oris_code,
    fac.facility_name,
    sel.mon_plan_id,
    (
        SELECT
            string_agg(
                    coalesce(unt.unitid, stp.stack_name),
                    ', ' :: text
        ORDER BY 
          unt.unitid,
                    stp.stack_name
            )
        FROM
            camdecmpswks.monitor_plan_location mpl
                JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id = mpl.mon_loc_id
                LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
                LEFT JOIN camdecmpswks.stack_pipe stp ON stp.stack_pipe_id = loc.stack_pipe_id
        WHERE
            mpl.mon_plan_id = sel.mon_plan_id
    ) AS configuration,
    esc.eval_status_cd,
    CASE WHEN esc.eval_status_cd = 'INQ' THEN COALESCE(
    'In Queue (#' || (
      SELECT 
        MIN(evaluation_queue_position) 
      FROM 
        evaluation_ord 
      WHERE 
        evaluation_ord.rpt_period_id = sel.rpt_period_id
        and evaluation_ord.mon_plan_id  = sel.mon_plan_id 
    ):: TEXT || ' in queue)', 
    esc.eval_status_cd_description
  ) ELSE esc.eval_status_cd_description END AS eval_status_cd_description, 
    sac.submission_availability_cd,
    CASE 
        WHEN sac.submission_availability_cd = 'PENDING' THEN 
            COALESCE(
                'Submitted, Host Update Pending (#' || (
                    SELECT MIN(submission_queue_position) 
                    FROM submission_ord 
                    WHERE 
                        submission_ord.rpt_period_id = sel.rpt_period_id
                        and submission_ord.mon_plan_id  = sel.mon_plan_id 
                )::TEXT || ' in queue)', 
                sac.sub_avail_cd_description
            )
        ELSE sac.sub_avail_cd_description 
    END AS submission_availability_cd_description,
    sel.userid :: varchar(160),
        sel.last_updated AS update_date,
    (
        SELECT
            esa.sub_availability_cd
        FROM
            (
                SELECT
                    sub.mon_plan_id,
                    sub.rpt_period_id,
                    max(sub.access_begin_date) AS last_access_begin_date
                FROM
                    camdecmpsaux.em_submission_access sub
                WHERE
                    sub.mon_plan_id = sel.mon_plan_id
                  AND sub.rpt_period_id = sel.rpt_period_id
                GROUP BY
                    sub.mon_plan_id,
                    sub.rpt_period_id
            ) lst1
                JOIN camdecmpsaux.EM_SUBMISSION_ACCESS esa ON esa.mon_plan_id = lst1.mon_plan_id
                AND esa.rpt_period_id = lst1.rpt_period_id
                AND esa.access_begin_date = lst1.last_access_begin_date
    ) AS window_status,
    prd.period_abbreviation
FROM
    (
        SELECT
            ems.eval_status_cd,
            ems.mon_plan_id,
            ems.rpt_period_id,
            ems.last_updated,
            (
                SELECT
                    max(smv.Userid)
                FROM
                    camdecmpswks.MONITOR_PLAN_LOCATION mpl
                        JOIN camdecmpswks.SUMMARY_VALUE smv ON smv.Mon_Loc_Id = mpl.Mon_Loc_Id
                        and smv.rpt_period_id = ems.rpt_period_id
                where
                    mpl.Mon_Plan_Id = ems.Mon_Plan_Id
            ) AS Userid,

            (
                SELECT
                    esa_1.em_sub_access_id
                FROM
                    camdecmpsaux.em_submission_access esa_1
                WHERE esa_1.mon_plan_id = ems.mon_plan_id
                  AND esa_1.rpt_period_id = ems.rpt_period_id
                  AND esa_1.access_begin_date =
                      (SELECT CASE
                                  -- If there's a non-'DELETE' record, pick its latest access_begin_date
                                  WHEN MAX(CASE WHEN esa2.sub_availability_cd != 'DELETE' THEN esa2.access_begin_date END) IS NOT NULL
                                      THEN MAX(CASE WHEN esa2.sub_availability_cd != 'DELETE' THEN esa2.access_begin_date END)

                                  -- Otherwise, pick the latest record (even if it is 'DELETE')
                                  ELSE MAX(esa2.access_begin_date)
                                  END
                       FROM camdecmpsaux.em_submission_access esa2
                       WHERE esa2.mon_plan_id = ems.mon_plan_id
                         AND esa2.rpt_period_id = ems.rpt_period_id)
            ) AS last_em_sub_access_id
        FROM
            (
                SELECT
                    ems.Mon_Plan_Id,
                    min(ems.rpt_period_id) AS earlist_quarter
                FROM
                    camdecmpswks.EMISSION_EVALUATION ems
                GROUP BY
                    ems.Mon_Plan_Id
            ) sel
                JOIN camdecmpswks.EMISSION_EVALUATION ems ON ems.Mon_Plan_Id = sel.Mon_Plan_Id
                AND ems.rpt_period_id = sel.earlist_quarter
    ) sel
        JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = sel.rpt_period_id
        JOIN camdecmpswks.monitor_plan pln ON pln.mon_plan_id = sel.mon_plan_id
        JOIN camd.plant fac ON fac.fac_id = pln.fac_id
        JOIN camdecmpsmd.eval_status_code esc ON esc.eval_status_cd :: text = sel.eval_status_cd :: text
  LEFT JOIN camdecmpsaux.em_submission_access esa ON esa.em_sub_access_id = sel.last_em_sub_access_id
    LEFT JOIN camdecmpsmd.submission_availability_code sac ON sac.submission_availability_cd = esa.sub_availability_cd
