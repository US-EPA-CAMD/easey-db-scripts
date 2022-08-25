CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_mngf (mondef_id, mon_plan_id, mon_loc_id, parameter_cd, begin_date, begin_hour, end_date, end_hour, operating_condition_cd, default_value, default_uom_cd, default_purpose_cd, default_source_cd, fuel_cd, group_id) AS
SELECT
    mondef_id, mon_plan_id, mon_loc_id, parameter_cd, begin_date, begin_hour, end_date, end_hour, operating_condition_cd, default_value, default_uom_cd, default_purpose_cd, default_source_cd, fuel_cd, group_id
    FROM camdecmpswks.vw_mp_monitor_default
    WHERE parameter_cd = 'MNGF';