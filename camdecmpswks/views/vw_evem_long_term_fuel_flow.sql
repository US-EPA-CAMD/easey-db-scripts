CREATE OR REPLACE VIEW camdecmpswks.vw_evem_summary_value (sum_value_id, mon_plan_id, rpt_period_id, mon_loc_id, parameter_cd, current_rpt_period_total, calc_current_rpt_period_total, os_total, calc_os_total, year_total, calc_year_total) AS
SELECT
    sv.sum_value_id, ml.mon_plan_id, sv.rpt_period_id, sv.mon_loc_id, sv.parameter_cd, sv.current_rpt_period_total, sv.calc_current_rpt_period_total, sv.os_total, sv.calc_os_total, sv.year_total, sv.calc_year_total
    FROM camdecmpswks.summary_value AS sv
    INNER JOIN camdecmpswks.vw_mp_monitor_location AS ml
        ON sv.mon_loc_id = ml.mon_loc_id;