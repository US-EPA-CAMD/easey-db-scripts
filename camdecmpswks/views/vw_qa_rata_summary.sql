-- View: camdecmpswks.vw_qa_rata_summary

-- DROP VIEW camdecmpswks.vw_qa_rata_summary;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_rata_summary
 AS
 SELECT ts.test_num,
    ts.gp_ind,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.sys_type_cd,
    ts.system_identifier,
    ts.mon_sys_id,
    rs.op_level_cd,
    rs.avg_gross_unit_load,
    rs.relative_accuracy,
    rs.bias_adj_factor,
    rs.mean_cem_value,
    rs.mean_diff,
    rs.mean_rata_ref_value,
    rs.aps_ind,
    rs.aps_cd,
    rs.stnd_dev_diff,
    rs.confidence_coef,
    rs.ref_method_cd,
    rs.co2_o2_ref_method_cd,
    rs.t_value,
    rs.stack_diameter,
    rs.stack_area,
    rs.calc_waf,
    rs.default_waf,
    rs.num_traverse_point,
    rs.rata_sum_id,
    ts.test_sum_id,
    ts.rata_id,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ts.needs_eval_flg,
    rs.userid,
    rs.add_date,
    rs.update_date
   FROM camdecmpswks.rata_summary rs
     JOIN camdecmpswks.vw_qa_test_summary_rata ts ON rs.rata_id::text = ts.rata_id::text;