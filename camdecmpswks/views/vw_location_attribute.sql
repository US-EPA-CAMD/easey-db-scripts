-- View: camdecmpswks.vw_location_attribute

DROP VIEW IF EXISTS camdecmpswks.vw_location_attribute;

CREATE OR REPLACE VIEW camdecmpswks.vw_location_attribute
 AS
 SELECT ml.stack_pipe_id,
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
    ml.fac_id,
    ml.oris_code,
    ml.non_load_based_ind,
    mla.mon_loc_attrib_id,
    mla.mon_loc_id,
        CASE
            WHEN ml.stack_pipe_id IS NULL THEN NULL::character varying
            ELSE ml.location_identifier
        END AS stack_name,
        CASE
            WHEN ml.unit_id IS NULL THEN NULL::character varying
            ELSE ml.location_identifier
        END AS unitid
   FROM camdecmpswks.monitor_location_attribute mla
     JOIN camdecmpswks.vw_monitor_location ml ON mla.mon_loc_id::text = ml.mon_loc_id::text;
