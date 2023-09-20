-- View: camdecmpswks.vw_mp_hrly_op_data

DROP VIEW IF EXISTS camdecmpswks.vw_mp_hrly_op_data;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_hrly_op_data
 AS
 SELECT hod.hour_id,
    vwml.mon_plan_id,
    vwml.mon_loc_id,
    vwml.location_name,
    rp.rpt_period_id,
    rp.calendar_year,
    rp.quarter,
    fc.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    hod.load_uom_cd,
    hod.op_time,
    hod.begin_date,
    hod.begin_hour,
    camdecmpswks.format_date_time(hod.begin_date, hod.begin_hour::integer::numeric, 0::numeric) AS begin_datehour,
    hod.hr_load,
    hod.load_range,
    hod.common_stack_load_range,
    hod.fc_factor,
    hod.fd_factor,
    hod.fw_factor,
    hod.multi_fuel_flg,
    hod.fuel_cd_list,
    hod.operating_condition_cd,
    vwml.stack_pipe_id,
    vwml.unit_id,
    hod.mhhi_indicator,
    hod.mats_load AS mats_hour_load,
    hod.mats_startup_shutdown_flg
   FROM camdecmpsmd.reporting_period rp
     JOIN camdecmpswks.hrly_op_data hod ON rp.rpt_period_id = hod.rpt_period_id
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON hod.mon_loc_id::text = vwml.mon_loc_id::text
     LEFT JOIN camdecmpsmd.fuel_code fc ON hod.fuel_cd::text = fc.fuel_cd::text;
