CREATE OR REPLACE VIEW camdecmpswks.vw_mp_component (component_id, mon_plan_id, mon_loc_id, component_identifier, model_version, serial_number, manufacturer, component_type_cd, acq_cd, basis_cd, fac_id, location_name) AS
SELECT
    component_id, mon_plan_id, vwMl.mon_loc_id, component_identifier, model_version, serial_number, manufacturer, component_type_cd, acq_cd, basis_cd, fac_id, location_name
    FROM camdecmpswks.component c
    INNER JOIN camdecmpswks.vw_mp_monitor_location vwMl
        ON c.mon_loc_id = vwMl.mon_loc_id;