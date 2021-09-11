-- View: camdecmpswks.vw_calibration_standard

-- DROP VIEW camdecmpswks.vw_calibration_standard;

CREATE OR REPLACE VIEW camdecmpswks.vw_calibration_standard
 AS
 SELECT cs.component_id,
    cs.cal_standard_cd,
    cs.cal_source_cd,
    cs.calibration_standard_id,
    cs.begin_date,
    cs.begin_hour,
    cs.end_date,
    cs.end_hour,
    c.component_type_cd,
    ml.mon_loc_id,
    c.serial_number,
    ml.oris_code,
    ml.location_identifier,
    c.manufacturer,
    c.acq_cd,
    c.basis_cd,
    c.model_version,
    c.component_identifier,
    ml.fac_id
   -- DO WE NEED CALIBRATION STANDARD IN WKS
   FROM camdecmps.calibration_standard cs
     JOIN camdecmpswks.component c ON cs.component_id::text = c.component_id::text
     JOIN camdecmpswks.vw_monitor_location ml ON c.mon_loc_id::text = ml.mon_loc_id::text;
