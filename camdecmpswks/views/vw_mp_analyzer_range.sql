-- View: camdecmpswks.vw_mp_analyzer_range

DROP VIEW IF EXISTS camdecmpswks.vw_mp_analyzer_range;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_analyzer_range
 AS
 SELECT c.component_id,
    ar.analyzer_range_cd,
    ar.dual_range_ind,
    ar.analyzer_range_id,
    camdecmpswks.format_date_time(ar.begin_date, ar.begin_hour::integer::numeric, 0::numeric) AS begin_datehour,
    ar.begin_date,
    ar.begin_hour,
    camdecmpswks.format_date_time(ar.end_date, ar.end_hour::integer::numeric, 0::numeric) AS end_datehour,
    ar.end_date,
    ar.end_hour,
    c.component_type_cd,
    ml.mon_loc_id,
    mp.mon_plan_id,
    c.serial_number,
    c.manufacturer,
    c.acq_cd,
    c.basis_cd,
    c.model_version,
    c.component_identifier,
    mp.fac_id
   FROM camdecmpswks.analyzer_range ar
     JOIN camdecmpswks.component c ON ar.component_id::text = c.component_id::text
     JOIN camdecmpswks.monitor_location ml ON c.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan_location mpl ON ml.mon_loc_id::text = mpl.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text;
