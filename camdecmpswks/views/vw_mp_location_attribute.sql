CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_fuel (mon_plan_id, mon_loc_id, uf_id, location_name, unit_name, dem_gcv, dem_so2, begin_date, end_date, indicator_cd, ozone_seas_ind, fuel_cd, fuel_group_cd, unit_id) AS
SELECT
    mpl.mon_plan_id, mpl.mon_loc_id, uf.uf_id, u.unitid AS location_name, u.unitid AS unit_name, uf.dem_gcv, uf.dem_so2, uf.begin_date, uf.end_date, uf.indicator_cd, uf.ozone_seas_ind, uf.fuel_cd, fc.fuel_group_cd, uf.unit_id
    FROM camdecmpswks.monitor_plan_location AS mpl
    INNER JOIN camdecmpswks.monitor_location AS ml
        ON mpl.mon_loc_id = ml.mon_loc_id
    INNER JOIN camdecmpswks.unit_fuel AS uf
        ON ml.unit_id = uf.unit_id
    INNER JOIN camd.unit AS u
        ON ml.unit_id = u.unit_id
    INNER JOIN camdecmpsmd.fuel_code AS fc
        ON uf.fuel_cd = fc.fuel_cd
UNION
SELECT
    mpl.mon_plan_id, mpl.mon_loc_id, uf.uf_id, camdecmpswks.stack_pipe.stack_name AS location_name, u.unitid AS unit_name, uf.dem_gcv, uf.dem_so2, uf.begin_date, uf.end_date, uf.indicator_cd, uf.ozone_seas_ind, uf.fuel_cd, fc.fuel_group_cd, uf.unit_id
    FROM camdecmpswks.monitor_plan_location AS mpl
    INNER JOIN camdecmpswks.monitor_location AS ml
        ON mpl.mon_loc_id = ml.mon_loc_id
    INNER JOIN camdecmpswks.unit_stack_configuration AS usc
        ON ml.stack_pipe_id = usc.stack_pipe_id
    INNER JOIN camd.unit AS u
        ON u.unit_id = usc.unit_id
    INNER JOIN camdecmpswks.unit_fuel AS uf
        ON usc.unit_id = uf.unit_id
    INNER JOIN camdecmpswks.stack_pipe
        ON usc.stack_pipe_id = camdecmpswks.stack_pipe.stack_pipe_id
    INNER JOIN camdecmpsmd.fuel_code AS fc
        ON uf.fuel_cd = fc.fuel_cd;