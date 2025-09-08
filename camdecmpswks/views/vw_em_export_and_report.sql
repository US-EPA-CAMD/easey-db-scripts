-- View: camdecmpswks.vw_em_export_and_report
DROP VIEW IF EXISTS camdecmpswks.vw_em_export_and_report;

CREATE OR REPLACE VIEW camdecmpswks.vw_em_export_and_report AS
SELECT
    fac.oris_code,
    fac.facility_name,
    ems.mon_plan_id,
    (
        SELECT
            string_agg(coalesce(unt.unitid, stp.stack_name), ', '::text ORDER BY unt.unitid, stp.stack_name)
        FROM
            camdecmpswks.monitor_plan_location mpl
            JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id = mpl.mon_loc_id
            LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
            LEFT JOIN camdecmpswks.stack_pipe stp ON stp.stack_pipe_id = loc.stack_pipe_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS configuration,
    esc.eval_status_cd,
    esc.eval_status_cd_description,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_cd_description,
    (
        SELECT
            max(smv.userid)
        FROM
            camdecmpswks.MONITOR_PLAN_LOCATION mpl
            JOIN camdecmpswks.SUMMARY_VALUE smv ON smv.mon_loc_id = mpl.mon_loc_id
                AND smv.rpt_period_id = ems.rpt_period_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS userid,
    ems.last_updated AS update_date,
    esa.sub_availability_cd AS window_status,
    esa.access_end_date AS window_expired_date,
    prd.period_abbreviation,
    sc.severity_cd,
    sc.severity_cd_description
FROM
    camdecmpswks.EMISSION_EVALUATION ems
    JOIN camdecmpsmd.REPORTING_PERIOD prd ON prd.rpt_period_id = ems.rpt_period_id
    JOIN camdecmpswks.MONITOR_PLAN pln ON pln.mon_plan_id = ems.mon_plan_id
    JOIN camd.PLANT fac ON fac.fac_id = pln.fac_id
    JOIN camdecmpsmd.EVAL_STATUS_CODE esc ON esc.eval_status_cd = ems.eval_status_cd
    LEFT JOIN camdecmpsaux.EM_SUBMISSION_ACCESS esa ON esa.mon_plan_id = ems.mon_plan_id
        AND esa.rpt_period_id = ems.rpt_period_id
        AND esa.access_begin_date = (
            SELECT
                CASE WHEN MAX(
                    CASE WHEN sub.sub_availability_cd NOT IN ('DELETE', 'NOTSUB') THEN
                        sub.access_begin_date
                    END
                ) IS NOT NULL
                -- If there's a non-'DELETE' record, pick its latest access_begin_date
                THEN
                    MAX(
                        CASE WHEN sub.sub_availability_cd NOT IN ('DELETE', 'NOTSUB') THEN
                            sub.access_begin_date
                        END
                    )
                    -- Otherwise, pick the latest record (even if it is 'DELETE')
                ELSE
                    MAX(sub.access_begin_date)
                END
            FROM
                camdecmpsaux.EM_SUBMISSION_ACCESS sub
            WHERE
                sub.mon_plan_id = ems.mon_plan_id
                AND sub.rpt_period_id = ems.rpt_period_id
        )
    LEFT JOIN camdecmpsmd.SUBMISSION_AVAILABILITY_CODE sac ON sac.submission_availability_cd = esa.sub_availability_cd
    LEFT JOIN camdecmpswks.check_session cs ON cs.chk_session_id = ems.chk_session_id
    LEFT JOIN camdecmpsmd.severity_code sc on sc.severity_cd = cs.severity_cd
