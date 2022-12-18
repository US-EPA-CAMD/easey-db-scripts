-- View: camdecmpswks.vw_qa_rata_traverse

DROP VIEW IF EXISTS camdecmpswks.vw_qa_rata_traverse;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_rata_traverse
 AS
 SELECT rr.rata_run_id,
    rr.rata_sum_id,
    rr.op_level_cd,
    rr.run_num,
    rr.sys_type_cd,
    rr.system_identifier,
    rr.begin_date AS run_begin_date,
    rr.begin_hour AS run_begin_hour,
    rr.end_date AS run_end_date,
    rr.end_hour AS run_end_hour,
    rr.rata_id,
    rr.test_sum_id,
    rr.mon_sys_id,
    rr.mon_loc_id,
    rr.fac_id,
    rr.location_identifier,
    rr.ref_method_cd,
    rr.flow_rata_run_id,
    rt.rata_traverse_id,
    rt.probeid,
    rr.default_waf,
    rt.probe_type_cd,
    rt.pressure_meas_cd,
    rt.method_traverse_point_id,
    rt.vel_cal_coef,
    rt.last_probe_date,
    rt.avg_vel_diff_pressure,
    rt.avg_sq_vel_diff_pressure,
    rt.t_stack_temp,
    rt.pitch_angle,
    rt.yaw_angle,
    rt.point_used_ind,
    rt.num_wall_effects_points,
    rt.calc_vel,
    rt.rep_vel,
    rt.add_date,
    rt.update_date,
    rt.userid
   FROM camdecmpswks.rata_traverse rt
     JOIN camdecmpswks.vw_qa_rata_run rr ON rt.flow_rata_run_id::text = rr.flow_rata_run_id::text;
