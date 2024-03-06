CREATE OR REPLACE VIEW camdecmps.vw_em_eval_and_submit AS
SELECT
    fac.oris_code,
    fac.facility_name,
    lst.mon_plan_id,
    (
        SELECT
            string_agg(coalesce(unt.unitid, stp.stack_name), ', '::text ORDER BY unt.unitid, stp.stack_name)
        FROM
            camdecmps.monitor_plan_location mpl
            JOIN camdecmps.monitor_location loc ON loc.mon_loc_id = mpl.mon_loc_id
            LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
            LEFT JOIN camdecmps.stack_pipe stp ON stp.stack_pipe_id = loc.stack_pipe_id
        WHERE
            mpl.mon_plan_id = lst.mon_plan_id) AS configuration,
        esa.userid,
        esa.update_date,
        esa.sub_availability_cd AS window_status,
        prd.period_abbreviation
    FROM (
        SELECT
            ems.mon_plan_id,
            ems.rpt_period_id,
            (
                SELECT
                    esa.em_sub_access_id
                FROM (
                    SELECT
                        sel.mon_plan_id,
                        sel.rpt_period_id,
                        max(sel.access_begin_date) AS last_access_begin_date
                    FROM
                        camdecmpsaux.em_submission_access sel
                    WHERE
                        sel.mon_plan_id = ems.mon_plan_id
                        AND sel.rpt_period_id = ems.rpt_period_id
                    GROUP BY
                        sel.mon_plan_id,
                        sel.rpt_period_id) lst
                    JOIN camdecmpsaux.EM_SUBMISSION_ACCESS esa ON esa.mon_plan_id = lst.mon_plan_id
                        AND esa.rpt_period_id = lst.rpt_period_id
                        AND esa.access_begin_date = lst.last_access_begin_date) AS last_em_sub_access_id
                FROM
                    camdecmps.emission_evaluation ems) lst
JOIN camdecmpsaux.em_submission_access esa ON esa.em_sub_access_id = lst.last_em_sub_access_id
JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = lst.rpt_period_id
JOIN camdecmps.monitor_plan pln ON pln.mon_plan_id = lst.mon_plan_id
JOIN camd.plant fac ON fac.fac_id = pln.fac_id
ORDER BY
    oris_code,
    configuration,
    period_abbreviation;
