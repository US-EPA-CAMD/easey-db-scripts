-- Table: camdecmps.rata_traverse

-- DROP TABLE camdecmps.rata_traverse;

CREATE TABLE IF NOT EXISTS camdecmps.rata_traverse
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
        REFERENCES camdecmps.flow_rata_run (flow_rata_run_id) MATCH SIMPLE
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

COMMENT ON TABLE camdecmps.rata_traverse
    IS 'Traverse point level data.  Record Type 615.';

COMMENT ON COLUMN camdecmps.rata_traverse.rata_traverse_id
    IS 'Unique identifier of a RATA traverse record. ';

COMMENT ON COLUMN camdecmps.rata_traverse.flow_rata_run_id
    IS 'Unique identifier of RATA run level record. ';

COMMENT ON COLUMN camdecmps.rata_traverse.probeid
    IS 'Probe ID. ';

COMMENT ON COLUMN camdecmps.rata_traverse.probe_type_cd
    IS 'Code used to identify a probe type. ';

COMMENT ON COLUMN camdecmps.rata_traverse.method_traverse_point_id
    IS 'Method 1 traverse point ID. ';

COMMENT ON COLUMN camdecmps.rata_traverse.vel_cal_coef
    IS 'Probe or pitot tube velocity calibration coefficient. ';

COMMENT ON COLUMN camdecmps.rata_traverse.last_probe_date
    IS 'Date of latest probe or pitot tube calibration. ';

COMMENT ON COLUMN camdecmps.rata_traverse.avg_vel_diff_pressure
    IS 'Average velocity differential pressure at traverse point. ';

COMMENT ON COLUMN camdecmps.rata_traverse.avg_sq_vel_diff_pressure
    IS 'Average of square roots of velocity differential pressures at traverse point. ';

COMMENT ON COLUMN camdecmps.rata_traverse.t_stack_temp
    IS 'T Stack temperature at traverse point. ';

COMMENT ON COLUMN camdecmps.rata_traverse.num_wall_effects_points
    IS 'Number of wall effects measurement points used to derive replacement velocity. ';

COMMENT ON COLUMN camdecmps.rata_traverse.yaw_angle
    IS 'Yaw angle of flow at traverse point. ';

COMMENT ON COLUMN camdecmps.rata_traverse.pitch_angle
    IS 'Pitch angle of flow at traverse point. ';

COMMENT ON COLUMN camdecmps.rata_traverse.calc_vel
    IS 'Calculated velocity at traverse point, not accounting for wall effects. ';

COMMENT ON COLUMN camdecmps.rata_traverse.calc_calc_vel
    IS 'Calculated velocity at traverse point, not accounting for wall effects. ';

COMMENT ON COLUMN camdecmps.rata_traverse.rep_vel
    IS 'Replacement velocity at traverse point, accounting for wall effects. ';

COMMENT ON COLUMN camdecmps.rata_traverse.pressure_meas_cd
    IS 'Code used to identify a pressure measurement device type. ';

COMMENT ON COLUMN camdecmps.rata_traverse.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.rata_traverse.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.rata_traverse.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.rata_traverse.point_used_ind
    IS 'Used to indicate that the traverse point is one of the four method 1 points closest to the stack wall and this test run was used to determine a WAF. ';

-- Index: idx_rata_traverse_flow_rata

-- DROP INDEX camdecmps.idx_rata_traverse_flow_rata;

CREATE INDEX IF NOT EXISTS idx_rata_traverse_flow_rata
    ON camdecmps.rata_traverse USING btree
    (flow_rata_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_rata_traverse_pressure_m

-- DROP INDEX camdecmps.idx_rata_traverse_pressure_m;

CREATE INDEX IF NOT EXISTS idx_rata_traverse_pressure_m
    ON camdecmps.rata_traverse USING btree
    (pressure_meas_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_rata_traverse_probe_type

-- DROP INDEX camdecmps.idx_rata_traverse_probe_type;

CREATE INDEX IF NOT EXISTS idx_rata_traverse_probe_type
    ON camdecmps.rata_traverse USING btree
    (probe_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
