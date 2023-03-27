-- View: camdecmpswks.vw_mp_component

DROP VIEW IF EXISTS camdecmpswks.vw_mp_component;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_component
 AS
 SELECT c.component_id,
    vwml.mon_plan_id,
    vwml.mon_loc_id,
    c.component_identifier,
    c.model_version,
    c.serial_number,
    c.manufacturer,
    c.component_type_cd,
    c.acq_cd,
    c.basis_cd,
    vwml.fac_id,
    vwml.location_name
   FROM camdecmpswks.component c
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON c.mon_loc_id::text = vwml.mon_loc_id::text;
