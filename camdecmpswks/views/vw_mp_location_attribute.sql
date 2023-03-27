-- View: camdecmpswks.vw_mp_location_attribute

DROP VIEW IF EXISTS camdecmpswks.vw_mp_location_attribute;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_attribute
 AS
 SELECT sp.stack_pipe_id,
    ml.unit_id,
    mla.grd_elevation,
    mla.duct_ind,
    mla.bypass_ind,
    mla.cross_area_flow,
    mla.cross_area_exit,
    mla.begin_date,
    mla.end_date,
    mla.stack_height,
    mla.shape_cd,
    mla.material_cd,
    mp.mon_plan_id,
    mp.fac_id,
    sp.stack_name,
    u.unitid,
    u.non_load_based_ind,
    mla.mon_loc_attrib_id,
    ml.mon_loc_id
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_location_attribute mla ON ml.mon_loc_id::text = mla.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text;
