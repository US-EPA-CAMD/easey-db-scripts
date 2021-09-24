-- View: camdecmpswks.vw_rect_duct_waf

-- DROP VIEW camdecmpswks.vw_rect_duct_waf;

CREATE OR REPLACE VIEW camdecmpswks.vw_rect_duct_waf
 AS
 SELECT rw.rect_duct_waf_data_id,
    rw.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    rw.waf_determined_date,
    rw.waf_effective_hour,
    rw.waf_effective_date,
    rw.end_date,
    rw.end_hour,
    rw.waf_method_cd,
    rw.waf_value,
    rw.num_test_runs,
    rw.num_test_ports,
    rw.num_traverse_points_waf,
    rw.num_traverse_points_ref,
    rw.duct_width,
    rw.duct_depth
   FROM camdecmpswks.rect_duct_waf rw
     JOIN camdecmpswks.vw_monitor_location ml ON rw.mon_loc_id::text = ml.mon_loc_id::text;
