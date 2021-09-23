-- View: camdecmpswks.vw_system_fuel_flow

-- DROP VIEW camdecmpswks.vw_system_fuel_flow;

CREATE OR REPLACE VIEW camdecmpswks.vw_system_fuel_flow
 AS
 SELECT sff.sys_fuel_id,
    ms.fac_id,
    ms.mon_loc_id,
    sff.mon_sys_id,
    sff.max_rate,
    sff.begin_date,
    sff.begin_hour,
    sff.end_date,
    sff.end_hour,
    sff.sys_fuel_uom_cd,
    sff.max_rate_source_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.fuel_cd
   FROM camdecmpswks.vw_monitor_system ms
     JOIN camdecmpswks.system_fuel_flow sff ON ms.mon_sys_id::text = sff.mon_sys_id::text;
