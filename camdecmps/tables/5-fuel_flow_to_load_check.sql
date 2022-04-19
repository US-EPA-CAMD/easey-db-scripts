-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.fuel_flow_to_load_check(
    fuel_flow_load_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    test_basis_cd CHARACTER VARYING(7),
    avg_diff NUMERIC(5,1),
    num_hrs NUMERIC(4,0),
    nhe_cofiring NUMERIC(4,0),
    nhe_ramping NUMERIC(4,0),
    nhe_low_range NUMERIC(4,0),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.fuel_flow_to_load_check
     IS 'Quarterly fuel flow-to-load tests for fuel flow meters.  Record Type 630.';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.fuel_flow_load_id
     IS 'Unique identifier of a fuel flow to load test record. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.test_sum_id
     IS 'Unique identifier of a test summary record. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.test_basis_cd
     IS 'Code used to identify the test basis (Q-flow-to-load ratio; H-gross heat rate). ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.avg_diff
     IS 'Quarterly average absolute percent difference between baseline ratio and hourly quarterly ratios. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.num_hrs
     IS 'Number of hours used in the quarterly data analysis. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.nhe_cofiring
     IS 'Number of hours excluded due to co-firing or combustion of a different type of fuel. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.nhe_ramping
     IS 'Number of hours excluded for load ramping up or down. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.nhe_low_range
     IS 'number of hours excluded in lower 25% of range of operation. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.userid
     IS 'User account or source of data that added or updated record. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.add_date
     IS 'Date and time in which record was added. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_check.update_date
     IS 'Date and time in which record was last updated. ';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_ffload_check_001
ON camdecmps.fuel_flow_to_load_check
USING BTREE (test_sum_id ASC);



CREATE INDEX idx_fuel_flow_to_lo_test_basis
ON camdecmps.fuel_flow_to_load_check
USING BTREE (test_basis_cd ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.fuel_flow_to_load_check
ADD CONSTRAINT pk_fuel_flow_to_load_check PRIMARY KEY (fuel_flow_load_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.fuel_flow_to_load_check
ADD CONSTRAINT fk_test_basis_fuel_flow_to FOREIGN KEY (test_basis_cd) 
REFERENCES camdecmpsmd.test_basis_code (test_basis_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.fuel_flow_to_load_check
ADD CONSTRAINT fk_test_summary_fuel_flow116 FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;
