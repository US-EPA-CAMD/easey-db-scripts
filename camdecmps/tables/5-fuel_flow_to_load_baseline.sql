-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.fuel_flow_to_load_baseline(
    fuel_flow_baseline_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    accuracy_test_number CHARACTER VARYING(18),
    pei_test_number CHARACTER VARYING(18),
    avg_fuel_flow_rate NUMERIC(10,1),
    avg_load NUMERIC(6,0),
    baseline_fuel_flow_load_ratio NUMERIC(6,2),
    avg_hrly_hi_rate NUMERIC(7,1),
    baseline_ghr NUMERIC(6,0),
    nhe_cofiring NUMERIC(4,0),
    nhe_ramping NUMERIC(4,0),
    nhe_low_range NUMERIC(4,0),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE,
    fuel_flow_load_uom_cd CHARACTER VARYING(7),
    ghr_uom_cd CHARACTER VARYING(7)
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.fuel_flow_to_load_baseline
     IS 'Optional baseline data for fuel flow-to-load ratio tests.  Record Type 629.';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.fuel_flow_baseline_id
     IS 'Unique identifier of fuel flow to load baseline record. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.test_sum_id
     IS 'Unique identifier of a test summary record. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.accuracy_test_number
     IS 'Test number of most recent fuel flowmeter accuracy test. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.pei_test_number
     IS 'Test number of most recent primary element inspection test. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.avg_fuel_flow_rate
     IS 'Average fuel flow rate (100 scfh for gas and lb/hr for oil). ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.avg_load
     IS 'Average load (MWe or 1000 lbs steam per hour). ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.baseline_fuel_flow_load_ratio
     IS 'Baseline fuel flow to load ratio. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.avg_hrly_hi_rate
     IS 'Average hourly heat input rate. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.baseline_ghr
     IS 'Baseline gross heat rate (GHR). ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.nhe_cofiring
     IS 'Number of hours excluded due to co-firing or combustion of a different type of fuel. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.nhe_ramping
     IS 'Number of hours excluded due to ramping. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.nhe_low_range
     IS 'Number of hours excluded in lower 25% of range of operation. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.userid
     IS 'User account or source of data that added or updated record. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.add_date
     IS 'Date and time in which record was added. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.update_date
     IS 'Date and time in which record was last updated. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.fuel_flow_load_uom_cd
     IS 'Code used to identify baseline fuel-flow-to-load units of measure. ';
COMMENT ON COLUMN camdecmps.fuel_flow_to_load_baseline.ghr_uom_cd
     IS 'Code used to identify baseline gross heat rate (GHR) units of measure. ';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_ffload_baseline_001
ON camdecmps.fuel_flow_to_load_baseline
USING BTREE (test_sum_id ASC);



CREATE INDEX idx_fuel_flow_to_lo_fuel_flow
ON camdecmps.fuel_flow_to_load_baseline
USING BTREE (fuel_flow_load_uom_cd ASC);



CREATE INDEX idx_fuel_flow_to_lo_ghr_uom_cd
ON camdecmps.fuel_flow_to_load_baseline
USING BTREE (ghr_uom_cd ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.fuel_flow_to_load_baseline
ADD CONSTRAINT pk_fuel_flow_to_load_baseline PRIMARY KEY (fuel_flow_baseline_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.fuel_flow_to_load_baseline
ADD CONSTRAINT fk_test_summary_fuel_flow_to_ FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.fuel_flow_to_load_baseline
ADD CONSTRAINT fk_units_of_meas_fuel_flow_to1 FOREIGN KEY (fuel_flow_load_uom_cd) 
REFERENCES camdecmpsmd.units_of_measure_code (uom_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.fuel_flow_to_load_baseline
ADD CONSTRAINT fk_units_of_meas_fuel_flow_to2 FOREIGN KEY (ghr_uom_cd) 
REFERENCES camdecmpsmd.units_of_measure_code (uom_cd)
ON DELETE NO ACTION;
