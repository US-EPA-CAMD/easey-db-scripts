-- View: camdecmpswks.vw_qa_flow_rata_run

-- DROP VIEW camdecmpswks.vw_qa_flow_rata_run;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_flow_rata_run
 AS
 SELECT rf.flow_rata_run_id,
    rf.num_traverse_point,
    rf.barometric_pressure,
    rf.static_stack_pressure,
    rf.percent_co2,
    rf.percent_o2,
    rf.percent_moisture,
    rf.dry_molecular_weight,
    rf.wet_molecular_weight,
    rf.avg_vel_wo_wall,
    rf.avg_vel_w_wall,
    rf.calc_waf,
    rf.avg_stack_flow_rate,
    rr.rata_run_id,
    rr.rata_sum_id,
    rr.op_level_cd,
    rr.run_num,
    rr.begin_date,
    rr.begin_hour,
    rr.begin_min,
    rr.end_date,
    rr.end_hour,
    rr.end_min,
    rr.run_status_cd,
    rr.level_calc_waf,
    rr.default_waf,
    rr.cem_value,
    rr.rata_ref_value,
    rf.userid,
    rf.add_date,
    rr.update_date,
    rr.test_num,
    rr.ref_method_cd,
    rr.sys_type_cd,
    rr.system_identifier,
    rr.stack_diameter,
    rr.rata_id,
    rr.test_sum_id,
    rr.mon_sys_id,
    rr.mon_loc_id
   FROM camdecmpswks.flow_rata_run rf
     JOIN camdecmpswks.vw_qa_rata_run rr ON rf.rata_run_id::text = rr.rata_run_id::text;
