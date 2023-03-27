-- View: camdecmpswks.vw_mp_monitor_span_co2

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_span_co2;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_span_co2
 AS
 SELECT ml.mon_plan_id,
    ms.span_id,
    ms.mon_loc_id,
    ms.mpc_value,
    ms.mec_value,
    ms.mpf_value,
    ms.max_low_range,
    ms.span_value,
    ms.full_scale_range,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour,
    ms.default_high_range,
    ms.flow_span_value,
    ms.flow_full_scale_range,
    ms.component_type_cd,
    ms.span_scale_cd,
    ms.span_method_cd,
    ms.span_uom_cd
   FROM camdecmpswks.monitor_span ms
     JOIN camdecmpswks.vw_mp_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text
  WHERE ms.component_type_cd::text = 'CO2'::text;
