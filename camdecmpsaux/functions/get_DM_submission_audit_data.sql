DROP FUNCTION IF EXISTS camdecmpsaux.get_DM_submission_audit_data(numeric, character varying, timestamp, timestamp);

CREATE OR REPLACE FUNCTION camdecmpsaux.get_DM_submission_audit_data(
    v_oris_code numeric,
    v_facility_name character varying,
    v_submission_from timestamp,
    v_submission_to timestamp
)
RETURNS TABLE (
    oris_code numeric,
    facility_name character varying,
    state character varying,
    locations text,
    quarter character varying,
    submission_id bigint,
    submission_time timestamp,
    pdem_status text,
    submitter character varying,
    last_loaded_submission_id bigint,
    last_loaded_time timestamp
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF v_oris_code IS NULL AND v_facility_name IS NULL THEN
        RETURN QUERY
        SELECT
            fac.oris_code,
            fac.facility_name,
            fac.state,
            (
                SELECT string_agg(coalesce(unt.unitid, stp.stack_name), ', ' ORDER BY stp.stack_name, unt.unitid)
                FROM camdecmps.MONITOR_PLAN_LOCATION mpl
                JOIN camdecmps.MONITOR_LOCATION loc USING (mon_loc_id)
                LEFT JOIN camd.UNIT unt USING (unit_id)
                LEFT JOIN camdecmps.STACK_PIPE stp USING (stack_pipe_id)
                WHERE mpl.mon_plan_id = pln.mon_plan_id
            ) AS locations,
            prd.period_abbreviation AS quarter,
            sbq.submission_id,
            sbq.completed_time AS submission_time,
            CASE (rpt.status_cd)
                WHEN 'COMPLETE' THEN 'Load Completed'
                WHEN 'FAILED' THEN 'Load Failed'
                WHEN 'WIP' THEN 'Load In-Progress'
                WHEN 'QUEUED' THEN 'Load Queued'
                ELSE 'Load Missing'
            END AS pdem_status,
            sbs.user_id AS submitter,
            (
                SELECT sub.submission_id
                FROM camdecmpsaux.PDEM_REPORT sub
                WHERE sub.mon_plan_id = sbs.mon_plan_id
                  AND sub.rpt_period_id = sbq.rpt_period_id
                  AND sub.status_cd = 'COMPLETE'
                ORDER BY sub.completed_time DESC, sub.pdem_report_id DESC
                LIMIT 1
            ) AS last_loaded_submission_id,
            (
                SELECT sub.completed_time
                FROM camdecmpsaux.PDEM_REPORT sub
                WHERE sub.mon_plan_id = sbs.mon_plan_id
                  AND sub.rpt_period_id = sbq.rpt_period_id
                  AND sub.status_cd = 'COMPLETE'
                ORDER BY sub.completed_time DESC, sub.pdem_report_id DESC
                LIMIT 1
            ) AS last_loaded_time
        FROM camdecmpsaux.SUBMISSION_QUEUE sbq
        JOIN camdecmpsaux.SUBMISSION_SET sbs USING (submission_set_id)
        JOIN camdecmps.MONITOR_PLAN pln USING (mon_plan_id)
        JOIN camdecmpsmd.REPORTING_PERIOD prd USING (rpt_period_id)
        JOIN camd.PLANT fac ON fac.fac_id = pln.fac_id
        LEFT JOIN camdecmpsaux.PDEM_REPORT rpt ON rpt.submission_id = sbq.submission_id
        WHERE sbq.completed_time >= COALESCE(v_submission_from, sbq.completed_time)
          AND sbq.completed_time <= COALESCE(v_submission_to, sbq.completed_time)
          AND sbq.process_cd = 'EM'
          AND sbq.status_cd = 'COMPLETE'
          AND sbq.severity_cd <> 'CRIT1'
          AND COALESCE(rpt.status_cd, 'MISSING') NOT IN ('COMPLETE', 'QUEUED', 'WIP')
        ORDER BY
            fac.oris_code,
            prd.period_abbreviation,
            sbq.submission_id;

    ELSE
        RETURN QUERY
        SELECT
            fac.oris_code,
            fac.facility_name,
            fac.state,
            (
                SELECT string_agg(coalesce(unt.unitid, stp.stack_name), ', ' ORDER BY stp.stack_name, unt.unitid)
                FROM camdecmps.MONITOR_PLAN_LOCATION mpl
                JOIN camdecmps.MONITOR_LOCATION loc USING (mon_loc_id)
                LEFT JOIN camd.UNIT unt USING (unit_id)
                LEFT JOIN camdecmps.STACK_PIPE stp USING (stack_pipe_id)
                WHERE mpl.mon_plan_id = pln.mon_plan_id
            ) AS locations,
            prd.period_abbreviation AS quarter,
            sbq.submission_id,
            sbq.completed_time AS submission_time,
            CASE (rpt.status_cd)
                WHEN 'COMPLETE' THEN 'Load Completed'
                WHEN 'FAILED' THEN 'Load Failed'
                WHEN 'WIP' THEN 'Load In-Progress'
                WHEN 'QUEUED' THEN 'Load Queued'
                ELSE 'Load Missing'
            END AS pdem_status,
            sbs.user_id AS submitter,
            (
                SELECT sub.submission_id
                FROM camdecmpsaux.PDEM_REPORT sub
                WHERE sub.mon_plan_id = sbs.mon_plan_id
                  AND sub.rpt_period_id = sbq.rpt_period_id
                  AND sub.status_cd = 'COMPLETE'
                ORDER BY sub.completed_time DESC, sub.pdem_report_id DESC
                LIMIT 1
            ) AS last_loaded_submission_id,
            (
                SELECT sub.completed_time
                FROM camdecmpsaux.PDEM_REPORT sub
                WHERE sub.mon_plan_id = sbs.mon_plan_id
                  AND sub.rpt_period_id = sbq.rpt_period_id
                  AND sub.status_cd = 'COMPLETE'
                ORDER BY sub.completed_time DESC, sub.pdem_report_id DESC
                LIMIT 1
            ) AS last_loaded_time
        FROM camd.PLANT fac
        JOIN camdecmps.MONITOR_PLAN pln USING (fac_id)
        JOIN camdecmpsaux.SUBMISSION_SET sbs USING (mon_plan_id)
        JOIN camdecmpsaux.SUBMISSION_QUEUE sbq USING (submission_set_id)
        JOIN camdecmpsmd.REPORTING_PERIOD prd USING (rpt_period_id)
        LEFT JOIN camdecmpsaux.PDEM_REPORT rpt ON rpt.submission_id = sbq.submission_id
        WHERE
            ((fac.oris_code = v_oris_code) OR (fac.facility_name = v_facility_name))
          AND sbq.completed_time >= COALESCE(v_submission_from, sbq.completed_time)
          AND sbq.completed_time <= COALESCE(v_submission_to, sbq.completed_time)
          AND sbq.process_cd = 'EM'
          AND sbq.status_cd = 'COMPLETE'
          AND sbq.severity_cd <> 'CRIT1'
          AND COALESCE(rpt.status_cd, 'MISSING') NOT IN ('COMPLETE', 'QUEUED', 'WIP')
        ORDER BY
            fac.oris_code,
            prd.period_abbreviation,
            sbq.submission_id;
    END IF;
END;
$$;