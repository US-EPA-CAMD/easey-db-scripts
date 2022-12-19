-- Table: camdecmpswks.rata_traverse

-- DROP TABLE camdecmpswks.rata_traverse;

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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    point_used_ind numeric(38,0),
    CONSTRAINT pk_rata_traverse PRIMARY KEY (rata_traverse_id),
    CONSTRAINT fk_rata_traverse_flow_rata_run FOREIGN KEY (flow_rata_run_id)
        REFERENCES camdecmpswks.flow_rata_run (flow_rata_run_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_rata_traverse_pressure_measure_code FOREIGN KEY (pressure_meas_cd)
        REFERENCES camdecmpsmd.pressure_measure_code (pressure_meas_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rata_traverse_probe_type_code FOREIGN KEY (probe_type_cd)
        REFERENCES camdecmpsmd.probe_type_code (probe_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);