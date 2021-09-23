-- View: camdecmpswks.vw_location_fuel

-- DROP VIEW camdecmpswks.vw_location_fuel;

CREATE OR REPLACE VIEW camdecmpswks.vw_location_fuel
 AS
 SELECT uf.uf_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    u.unit_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uf.fuel_type AS fuel_cd,
    uf.dem_gcv,
    uf.dem_so2,
    uf.indicator_cd,
    uf.ozone_seas_ind,
    fc.fuel_group_cd,
        CASE
            WHEN usc.begin_date IS NULL THEN uf.begin_date
            WHEN uf.begin_date IS NULL THEN usc.begin_date
            WHEN uf.begin_date >= usc.begin_date THEN uf.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN uf.end_date
            WHEN uf.end_date IS NULL THEN usc.end_date
            WHEN uf.end_date <= usc.end_date THEN uf.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camdecmpswks.unit_fuel uf ON usc.unit_id = uf.unit_id AND (usc.end_date IS NULL OR uf.begin_date <= usc.end_date) AND (uf.end_date IS NULL OR uf.end_date >= usc.begin_date)
     JOIN camd.unit u ON u.unit_id = usc.unit_id
     JOIN camdecmpsmd.fuel_code fc ON fc.fuel_cd::text = uf.fuel_type::text
UNION
 SELECT uf.uf_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    u.unit_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uf.fuel_type AS fuel_cd,
    uf.dem_gcv,
    uf.dem_so2,
    uf.indicator_cd,
    uf.ozone_seas_ind,
    fc.fuel_group_cd,
    uf.begin_date,
    uf.end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_fuel uf ON ml.unit_id = uf.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id
     JOIN camdecmpsmd.fuel_code fc ON fc.fuel_cd::text = uf.fuel_type::text;
