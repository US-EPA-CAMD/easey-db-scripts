CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_load (mon_plan_id, fac_id, oris_code, location_name, load_id, mon_loc_id, load_analysis_date, begin_date, begin_hour, end_date, end_hour, max_load_value, second_normal_ind, up_op_boundary, low_op_boundary, normal_level_cd, second_level_cd, max_load_uom_cd) AS
SELECT
    loc.mon_plan_id, loc.fac_id, loc.oris_code, loc.location_name, ml.load_id, ml.mon_loc_id, ml.load_analysis_date, ml.begin_date, ml.begin_hour, ml.end_date, ml.end_hour, ml.max_load_value, ml.second_normal_ind, ml.up_op_boundary, ml.low_op_boundary, ml.normal_level_cd, ml.second_level_cd, ml.max_load_uom_cd
    FROM camdecmpswks.monitor_load AS ml
    INNER JOIN camdecmpswks.vw_mp_monitor_location AS loc
        ON ml.mon_loc_id = loc.mon_loc_id;