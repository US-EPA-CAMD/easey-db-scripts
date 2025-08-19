 -- View: camdecmpswks.vw_mp_locations_and_unit_stack_configurations

DROP VIEW IF EXISTS camdecmpswks.vw_mp_locations_and_unit_stack_configurations;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_locations_and_unit_stack_configurations
AS
SELECT
    mp.mon_plan_id,
    p.oris_code,
    mp.fac_id,
    p.facility_name,
    p.frs_id,
    mp.config_type_cd,
    mp.last_updated,
    mp.updated_status_flg,
    mp.needs_eval_flg,
    mp.chk_session_id,
    mp.userid,
    mp.add_date,
    mp.update_date,
    mp.submission_id,
    mp.submission_availability_cd,
    mp.pending_status_cd,
    mp.begin_rpt_period_id,
    rpb.period_abbreviation AS begin_period_abbreviation,
    mp.end_rpt_period_id,
    rpe.period_abbreviation AS end_period_abbreviation,
    mp.last_evaluated_date,
    mp.eval_status_cd,
    esc.eval_status_cd_description,
    sac.sub_avail_cd_description,
    sc.severity_cd_description,
    sc.severity_cd,
    (
        SELECT string_agg(COALESCE(unt.unitid, stp.stack_name), ', ' ORDER BY unt.unitid, stp.stack_name)
        FROM camdecmpswks.monitor_plan_location mpl
            JOIN camdecmpswks.monitor_location loc USING (mon_loc_id)
            LEFT JOIN camdecmpswks.unit unt USING (unit_id)
            LEFT JOIN camdecmpswks.stack_pipe stp USING (stack_pipe_id)
        WHERE mpl.mon_plan_id = mp.mon_plan_id
    ) AS locations
FROM camdecmpswks.monitor_plan mp
    INNER JOIN camd.plant p ON mp.fac_id = p.fac_id
    INNER JOIN camdecmpsmd.reporting_period rpb ON mp.begin_rpt_period_id = rpb.rpt_period_id
    LEFT JOIN camdecmpsmd.reporting_period rpe ON mp.end_rpt_period_id = rpe.rpt_period_id
    INNER JOIN camdecmpsmd.eval_status_code esc ON mp.eval_status_cd = esc.eval_status_cd
    LEFT JOIN camdecmpsmd.submission_availability_code sac ON mp.submission_availability_cd = sac.submission_availability_cd
    LEFT JOIN camdecmpswks.check_session cs ON cs.chk_session_id = mp.chk_session_id
    LEFT JOIN camdecmpsmd.severity_code sc ON sc.severity_cd = cs.severity_cd;