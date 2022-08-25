CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default (mondef_id, mon_plan_id, mon_loc_id, parameter_cd, begin_date, begin_hour, end_date, end_hour, operating_condition_cd, default_value, default_uom_cd, default_purpose_cd, default_source_cd, fuel_cd, group_id) AS
SELECT
    md.mondef_id, ml.mon_plan_id, md.mon_loc_id, md.parameter_cd, md.begin_date, md.begin_hour, md.end_date, md.end_hour, md.operating_condition_cd, md.default_value, md.default_uom_cd, md.default_purpose_cd, md.default_source_cd, md.fuel_cd, md.group_id
    FROM camdecmpswks.monitor_default AS md
    INNER JOIN camdecmpswks.vw_mp_monitor_location AS ml
        ON md.mon_loc_id = ml.mon_loc_id;