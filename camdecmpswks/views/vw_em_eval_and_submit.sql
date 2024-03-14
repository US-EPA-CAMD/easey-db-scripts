-- View: camdecmpswks.vw_em_eval_and_submit
DROP VIEW IF EXISTS camdecmpswks.vw_em_eval_and_submit;

CREATE OR REPLACE VIEW camdecmpswks.vw_em_eval_and_submit AS
SELECT
    p.oris_code,
    p.facility_name,
    mp.mon_plan_id,
    (
        SELECT
            string_agg(coalesce(unt.unitid, stp.stack_name), ', '::text ORDER BY unt.unitid, stp.stack_name)
        FROM
            camdecmpswks.monitor_plan_location mpl
            JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id = mpl.mon_loc_id
            LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
            LEFT JOIN camdecmpswks.stack_pipe stp ON stp.stack_pipe_id = loc.stack_pipe_id
        WHERE
            mpl.mon_plan_id = mp.mon_plan_id) AS configuration,
        esc.eval_status_cd,
        esc.eval_status_cd_description,
        sac.submission_availability_cd,
        sac.sub_avail_cd_description AS submission_availability_cd_description,
        esa.userid,
        COALESCE(esa.update_date, esa.add_date) AS update_date,
        esa.sub_availability_cd AS window_status,
        rpt.period_abbreviation
    FROM
        camd.plant p
        JOIN camdecmpswks.monitor_plan mp ON mp.fac_id = p.fac_id
        JOIN camdecmpswks.emission_evaluation ee ON ee.mon_plan_id = mp.mon_plan_id
        JOIN camdecmpsmd.reporting_period rpt ON rpt.rpt_period_id = ee.rpt_period_id
        JOIN camdecmpsmd.eval_status_code esc ON esc.eval_status_cd::text = ee.eval_status_cd::text
        JOIN (
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
                            sel.rpt_period_id) lst1
                        JOIN camdecmpsaux.EM_SUBMISSION_ACCESS esa ON esa.mon_plan_id = lst1.mon_plan_id
                            AND esa.rpt_period_id = lst1.rpt_period_id
                            AND esa.access_begin_date = lst1.last_access_begin_date) AS last_em_sub_access_id
                    FROM
                        camdecmpswks.emission_evaluation ems) lst ON lst.mon_plan_id = ee.mon_plan_id
        AND lst.rpt_period_id = ee.rpt_period_id
    LEFT JOIN camdecmpsaux.em_submission_access esa ON esa.em_sub_access_id = lst.last_em_sub_access_id
    LEFT JOIN camdecmpsmd.submission_availability_code sac ON sac.submission_availability_cd = esa.sub_availability_cd
ORDER BY
    p.oris_code,
    configuration,
    rpt.period_abbreviation;
