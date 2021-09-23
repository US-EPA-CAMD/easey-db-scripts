-- View: camdecmpswks.vw_component

-- DROP VIEW camdecmpswks.vw_component;

CREATE OR REPLACE VIEW camdecmpswks.vw_component
 AS
 SELECT c.component_id,
    c.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    c.component_identifier,
    c.model_version,
    c.serial_number,
    c.manufacturer,
    c.component_type_cd,
    c.acq_cd,
    c.basis_cd,
    ml.fac_id,
    c.hg_converter_ind
   FROM camdecmpswks.component c
     JOIN camdecmpswks.vw_monitor_location ml ON c.mon_loc_id::text = ml.mon_loc_id::text;
