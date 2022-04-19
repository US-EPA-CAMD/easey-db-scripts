-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.rata_traverse(
    rata_traverse_id CHARACTER VARYING(45) NOT NULL,
    flow_rata_run_id CHARACTER VARYING(45) NOT NULL,
    probeid CHARACTER VARYING(11),
    probe_type_cd CHARACTER VARYING(7),
    method_traverse_point_id CHARACTER VARYING(3) NOT NULL,
    vel_cal_coef NUMERIC(5,3),
    last_probe_date DATE,
    avg_vel_diff_pressure NUMERIC(5,3),
    avg_sq_vel_diff_pressure NUMERIC(5,3),
    t_stack_temp NUMERIC(5,1),
    num_wall_effects_points NUMERIC(2,0),
    yaw_angle NUMERIC(6,1),
    pitch_angle NUMERIC(6,1),
    calc_vel NUMERIC(6,2),
    calc_calc_vel NUMERIC(6,2),
    rep_vel NUMERIC(6,2),
    pressure_meas_cd CHARACTER VARYING(7),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE,
    point_used_ind NUMERIC(38,0)
)
        WITH (
        OIDS=FALSE
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



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_rata_traverse_flow_rata
ON camdecmps.rata_traverse
USING BTREE (flow_rata_run_id ASC);



CREATE INDEX idx_rata_traverse_pressure_m
ON camdecmps.rata_traverse
USING BTREE (pressure_meas_cd ASC);



CREATE INDEX idx_rata_traverse_probe_type
ON camdecmps.rata_traverse
USING BTREE (probe_type_cd ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.rata_traverse
ADD CONSTRAINT pk_rata_traverse PRIMARY KEY (rata_traverse_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.rata_traverse
ADD CONSTRAINT fk_flow_rata_run_rata_traverse FOREIGN KEY (flow_rata_run_id) 
REFERENCES camdecmps.flow_rata_run (flow_rata_run_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.rata_traverse
ADD CONSTRAINT fk_pressure_meas_rata_traverse FOREIGN KEY (pressure_meas_cd) 
REFERENCES camdecmpsmd.pressure_measure_code (pressure_meas_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.rata_traverse
ADD CONSTRAINT fk_probe_type_co_rata_traverse FOREIGN KEY (probe_type_cd) 
REFERENCES camdecmpsmd.probe_type_code (probe_type_cd)
ON DELETE NO ACTION;
