CREATE OR REPLACE VIEW camdecmpswks.vw_mp_hrly_fuel_flow (hrly_fuel_flow_id, hour_id, mon_plan_id, mon_loc_id, rpt_period_id, calendar_year, quarter, begin_date, begin_hour, mon_sys_id, fuel_cd, fuel_group_cd, unit_fuel_cd, fuel_usage_time, volumetric_flow_rate, calc_volumetric_flow_rate, volumetric_uom_cd, sod_volumetric_cd, mass_flow_rate, calc_mass_flow_rate, sod_mass_cd, system_identifier, sys_type_cd, sys_designation_cd, system_begin_date) AS
SELECT
    hrly_fuel_flow_id, hff.hour_id, mon_plan_id, vwHod.mon_loc_id, vwHod.rpt_period_id, calendar_year, quarter, vwHod.begin_date, vwHod.begin_hour, ms.mon_sys_id, fc.fuel_cd, fc.fuel_group_cd, fc.unit_fuel_cd, fuel_usage_time, volumetric_flow_rate, calc_volumetric_flow_rate, volumetric_uom_cd, sod_volumetric_cd, mass_flow_rate, calc_mass_flow_rate, sod_mass_cd, system_identifier, sys_type_cd, sys_designation_cd, ms.begin_date AS system_begin_date
    FROM camdecmpswks.vw_mp_hrly_op_data vwHod
    INNER JOIN camdecmpswks.hrly_fuel_flow hff
        ON vwHod.hour_id = hff.hour_id
    LEFT OUTER JOIN camdecmpsmd.fuel_code fc
        ON hff.fuel_cd = fc.fuel_cd
    LEFT OUTER JOIN camdecmpswks.monitor_system ms
        ON hff.mon_sys_id = ms.mon_sys_id;