CREATE OR REPLACE VIEW camdecmpswks.vw_mp_analyzer_range (component_id, analyzer_range_cd, dual_range_ind, analyzer_range_id, begin_datehour, begin_date, begin_hour, end_datehour, end_date, end_hour, component_type_cd, mon_loc_id, mon_plan_id, serial_number, manufacturer, acq_cd, basis_cd, model_version, component_identifier, fac_id) AS
SELECT
    c.component_id, analyzer_range_cd, dual_range_ind, analyzer_range_id, camdecmpswks.format_date_time(ar.begin_date, ar.begin_hour::INTEGER, 0) AS begin_datehour, ar.begin_date, ar.begin_hour, camdecmpswks.format_date_time(ar.end_date, ar.end_hour::INTEGER, 0) AS end_datehour, ar.end_date, ar.end_hour, component_type_cd, ml.mon_loc_id, mp.mon_plan_id, serial_number, manufacturer, acq_cd, basis_cd, model_version, component_identifier, fac_id
    FROM camdecmpswks.analyzer_range ar
    INNER JOIN camdecmpswks.component c
        ON ar.component_id = c.component_id
    INNER JOIN camdecmpswks.monitor_location ml
        ON c.mon_loc_id = ml.mon_loc_id
    INNER JOIN camdecmpswks.monitor_plan_location mpl
        ON ml.mon_loc_id = mpl.mon_loc_id
    INNER JOIN camdecmpswks.monitor_plan mp
        ON mpl.mon_plan_id = mp.mon_plan_id;