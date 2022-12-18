-- View: camdecmpswks.vw_system_analyzer_range

DROP VIEW IF EXISTS camdecmpswks.vw_system_analyzer_range;

CREATE OR REPLACE VIEW camdecmpswks.vw_system_analyzer_range
 AS
 SELECT ar.component_id,
    ar.analyzer_range_cd,
    ar.dual_range_ind,
    ar.analyzer_range_id,
    msc.component_type_cd,
    ml.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    msc.acq_cd,
    msc.basis_cd,
    msc.component_identifier,
    ml.fac_id,
    msc.mon_sys_id,
    msc.system_identifier,
        CASE
            WHEN msc.begin_date IS NULL THEN ar.begin_date
            WHEN ar.begin_date IS NULL THEN msc.begin_date
            WHEN msc.begin_date < ar.begin_date THEN ar.begin_date
            ELSE msc.begin_date
        END AS begin_date,
        CASE
            WHEN msc.begin_date IS NULL THEN ar.begin_hour
            WHEN ar.begin_date IS NULL THEN msc.begin_hour
            WHEN msc.begin_date < ar.begin_date THEN ar.begin_hour
            WHEN msc.begin_date = ar.begin_date AND msc.begin_hour < ar.begin_hour THEN ar.begin_hour
            ELSE msc.begin_hour
        END AS begin_hour,
        CASE
            WHEN msc.end_date IS NULL THEN ar.end_date
            WHEN ar.end_date IS NULL THEN msc.end_date
            WHEN msc.end_date > ar.end_date THEN ar.end_date
            ELSE msc.end_date
        END AS end_date,
        CASE
            WHEN msc.end_date IS NULL THEN ar.end_hour
            WHEN ar.end_date IS NULL THEN msc.end_hour
            WHEN msc.end_date > ar.end_date THEN ar.end_hour
            WHEN msc.end_date = ar.end_date AND msc.end_hour > ar.end_hour THEN ar.end_hour
            ELSE msc.end_hour
        END AS end_hour
   FROM camdecmpswks.analyzer_range ar
     JOIN camdecmpswks.vw_monitor_system_component msc ON ar.component_id::text = msc.component_id::text
     JOIN camdecmpswks.vw_monitor_location ml ON msc.mon_loc_id::text = ml.mon_loc_id::text;
