CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_span_nox (mon_plan_id, span_id, mon_loc_id, mpc_value, mec_value, mpf_value, max_low_range, span_value, full_scale_range, begin_date, begin_hour, end_date, end_hour, default_high_range, flow_span_value, flow_full_scale_range, component_type_cd, span_scale_cd, span_method_cd, span_uom_cd) AS
SELECT
    ml.mon_plan_id, ms.span_id, ms.mon_loc_id, ms.mpc_value, ms.mec_value, ms.mpf_value, ms.max_low_range, ms.span_value, ms.full_scale_range, ms.begin_date, ms.begin_hour, ms.end_date, ms.end_hour, ms.default_high_range, ms.flow_span_value, ms.flow_full_scale_range, ms.component_type_cd, ms.span_scale_cd, ms.span_method_cd, ms.span_uom_cd
    FROM camdecmpswks.monitor_span AS ms
    INNER JOIN camdecmpswks.vw_mp_monitor_location AS ml
        ON ms.mon_loc_id = ml.mon_loc_id
    WHERE ms.component_type_cd = 'NOX';