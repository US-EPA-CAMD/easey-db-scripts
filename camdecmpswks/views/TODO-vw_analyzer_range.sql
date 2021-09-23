CREATE OR REPLACE  VIEW camdecmpswks.vw_analyzer_range (component_id, analyzer_range_cd, dual_range_ind, analyzer_range_id, begin_datehour, begin_date, begin_hour, end_datehour, end_date, end_hour, component_type_cd, mon_loc_id, serial_number, oris_code, location_identifier, manufacturer, acq_cd, basis_cd, model_version, component_identifier, fac_id) AS
SELECT
    ar.component_id, ar.analyzer_range_cd, ar.dual_range_ind, ar.analyzer_range_id, camdecmpswks.formatdatetime(ar.begin_date, ar.begin_hour::INTEGER, 0) AS begin_datehour, ar.begin_date, ar.begin_hour, camdecmpswks.formatdatetime(ar.end_date, ar.end_hour::INTEGER, 0) AS end_datehour, ar.end_date, ar.end_hour, c.component_type_cd, ml.mon_loc_id, c.serial_number, ml.oris_code, ml.location_identifier, c.manufacturer, c.acq_cd, c.basis_cd, c.model_version, c.component_identifier, ml.fac_id
    FROM camdecmpswks.analyzer_range ar
    INNER JOIN camdecmpswks.component c
        ON ar.component_id = c.component_id
    INNER JOIN camdecmpswks.vw_monitor_location ml
        ON c.mon_loc_id = ml.mon_loc_id;