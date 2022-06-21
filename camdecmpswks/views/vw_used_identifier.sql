-- View: camdecmpswks.vw_used_identifier

-- DROP VIEW camdecmpswks.vw_used_identifier;

CREATE OR REPLACE VIEW camdecmpswks.vw_used_identifier
 AS
 SELECT ui.mon_loc_id,
    ui.table_cd,
    ui.identifier,
    ui.type_or_parameter_cd,
    ui.formula_or_basis_cd,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id
   FROM camdecmpswks.used_identifier ui
     JOIN camdecmpswks.vw_monitor_location ml ON ui.mon_loc_id::text = ml.mon_loc_id::text;
