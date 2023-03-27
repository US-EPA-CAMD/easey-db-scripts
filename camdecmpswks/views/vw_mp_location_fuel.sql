-- View: camdecmpswks.vw_mp_location_fuel

DROP VIEW IF EXISTS camdecmpswks.vw_mp_location_fuel;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_fuel
 AS
 SELECT mpl.mon_plan_id,
    mpl.mon_loc_id,
    uf.uf_id,
    u.unitid AS location_name,
    u.unitid AS unit_name,
    uf.dem_gcv,
    uf.dem_so2,
    uf.begin_date,
    uf.end_date,
    uf.indicator_cd,
    uf.ozone_seas_ind,
    uf.fuel_type AS fuel_cd,
    fc.fuel_group_cd,
    uf.unit_id
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.unit_fuel uf ON ml.unit_id = uf.unit_id
     JOIN camd.unit u ON ml.unit_id = u.unit_id
     JOIN camdecmpsmd.fuel_code fc ON uf.fuel_type::text = fc.fuel_cd::text
UNION
 SELECT mpl.mon_plan_id,
    mpl.mon_loc_id,
    uf.uf_id,
    stack_pipe.stack_name AS location_name,
    u.unitid AS unit_name,
    uf.dem_gcv,
    uf.dem_so2,
    uf.begin_date,
    uf.end_date,
    uf.indicator_cd,
    uf.ozone_seas_ind,
    uf.fuel_type AS fuel_cd,
    fc.fuel_group_cd,
    uf.unit_id
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit u ON u.unit_id = usc.unit_id
     JOIN camdecmpswks.unit_fuel uf ON usc.unit_id = uf.unit_id
     JOIN camdecmpswks.stack_pipe ON usc.stack_pipe_id::text = stack_pipe.stack_pipe_id::text
     JOIN camdecmpsmd.fuel_code fc ON uf.fuel_type::text = fc.fuel_cd::text;
