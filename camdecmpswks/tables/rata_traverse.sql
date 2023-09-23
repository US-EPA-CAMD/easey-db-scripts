CREATE TABLE IF NOT EXISTS camdecmpswks.rata_traverse
(
    rata_traverse_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    flow_rata_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    probeid character varying(11) COLLATE pg_catalog."default",
    probe_type_cd character varying(7) COLLATE pg_catalog."default",
    method_traverse_point_id character varying(3) COLLATE pg_catalog."default" NOT NULL,
    vel_cal_coef numeric(5,3),
    last_probe_date date,
    avg_vel_diff_pressure numeric(5,3),
    avg_sq_vel_diff_pressure numeric(5,3),
    t_stack_temp numeric(5,1),
    num_wall_effects_points numeric(2,0),
    yaw_angle numeric(6,1),
    pitch_angle numeric(6,1),
    calc_vel numeric(6,2),
    calc_calc_vel numeric(6,2),
    rep_vel numeric(6,2),
    pressure_meas_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    point_used_ind numeric(38,0)
);