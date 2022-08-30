CREATE OR REPLACE VIEW camdecmpswks.vw_mp_hrly_op_data (hour_id, mon_plan_id, mon_loc_id, location_name, rpt_period_id, calendar_year, quarter, fuel_cd, fuel_group_cd, unit_fuel_cd, load_uom_cd, op_time, begin_date, begin_hour, begin_datehour, hr_load, load_range, common_stack_load_range, fc_factor, fd_factor, fw_factor, multi_fuel_flg, fuel_cd_list, operating_condition_cd, stack_pipe_id, unit_id, mhhi_indicator, mats_hour_load, mats_startup_shutdown_flg) AS
SELECT
    hour_id, mon_plan_id, vwMl.mon_loc_id, location_name, rp.rpt_period_id, calendar_year, quarter, fc.fuel_cd, fuel_group_cd, unit_fuel_cd, load_uom_cd, op_time, hod.begin_date, begin_hour, camdecmpswks.format_date_time(hod.begin_date, hod.begin_hour::INTEGER, 0) AS begin_datehour, hr_load, load_range, common_stack_load_range, fc_factor, fd_factor, fw_factor, multi_fuel_flg, fuel_cd_list, operating_condition_cd, stack_pipe_id, unit_id, mhhi_indicator, mats_load AS mats_hour_load, mats_startup_shutdown_flg
    FROM camdecmpsmd.reporting_period rp
    INNER JOIN camdecmpswks.hrly_op_data hod
        ON rp.rpt_period_id = hod.rpt_period_id
    INNER JOIN camdecmpswks.vw_mp_monitor_location vwMl
        ON hod.mon_loc_id = vwMl.mon_loc_id
    LEFT OUTER JOIN camdecmpsmd.fuel_code fc
        ON hod.fuel_cd = fc.fuel_cd;