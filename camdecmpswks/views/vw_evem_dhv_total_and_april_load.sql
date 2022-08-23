CREATE OR REPLACE VIEW camdecmpswks.vw_evem_dhv_total_and_april_load (mon_plan_id, fac_id, mon_loc_id, oris_code, location_name, rpt_period_id, parameter_cd, modc_cd, total, april, total_optime, april_optime, problem_occurred) AS
SELECT
    pln.mon_plan_id, pln.fac_id, mpl.mon_loc_id, fac.oris_code,
    CASE
        WHEN unt.unit_id IS NOT NULL THEN unt.unitid
        WHEN stp.stack_pipe_id IS NOT NULL THEN stp.stack_name
        ELSE NULL
    END AS location_name, hod.rpt_period_id, dhv.parameter_cd, dhv.modc_cd, SUM(CASE
        WHEN hod.hr_load >= 0 AND hod.op_time > 0 AND hod.op_time <= 1 AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL THEN hod.op_time * hod.hr_load
        ELSE NULL
    END) AS total, SUM(CASE
        WHEN hod.hr_load >= 0 AND hod.op_time > 0 AND hod.op_time <= 1 AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL AND date_part('month', hod.begin_date::TIMESTAMP) = 4 THEN hod.op_time * hod.hr_load
        ELSE NULL
    END) AS april, SUM(CASE
        WHEN hod.op_time > 0 AND hod.op_time <= 1 AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL THEN hod.op_time
        ELSE NULL
    END) AS total_optime, SUM(CASE
        WHEN hod.op_time > 0 AND hod.op_time <= 1 AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL AND date_part('month', hod.begin_date::TIMESTAMP) = 4 THEN hod.op_time
        ELSE NULL
    END) AS april_optime, MAX(CASE
        WHEN hod.hr_load >= 0 AND hod.op_time > 0 AND hod.op_time <= 1 THEN
        CASE
            WHEN dhv.hour_id IS NULL AND (hod.hr_load > 0 OR hod.op_time > 0) THEN 1
            ELSE 0
        END
        ELSE 1
    END) AS problem_occurred
    FROM camdecmpswks.monitor_plan AS pln
    LEFT OUTER JOIN camd.plant AS fac
        ON fac.fac_id = pln.fac_id
    INNER JOIN camdecmpswks.monitor_plan_location AS mpl
        ON mpl.mon_plan_id = pln.mon_plan_id
    INNER JOIN camdecmpswks.monitor_location AS loc
        ON loc.mon_loc_id = mpl.mon_loc_id
    LEFT OUTER JOIN camd.unit AS unt
        ON unt.unit_id = loc.unit_id
    LEFT OUTER JOIN camdecmpswks.stack_pipe AS stp
        ON stp.stack_pipe_id = loc.stack_pipe_id
    INNER JOIN camdecmpswks.hrly_op_data AS hod
        ON hod.mon_loc_id = loc.mon_loc_id
    LEFT OUTER JOIN camdecmpswks.derived_hrly_value AS dhv
        ON dhv.hour_id = hod.hour_id AND dhv.parameter_cd = 'HIT'
    WHERE (hod.op_time != 0 OR hod.hr_load IS NOT NULL)
    GROUP BY pln.mon_plan_id, pln.fac_id, mpl.mon_loc_id, fac.oris_code, unt.unit_id, unt.unitid, stp.stack_pipe_id, stp.stack_name, hod.rpt_period_id, dhv.parameter_cd, dhv.modc_cd;