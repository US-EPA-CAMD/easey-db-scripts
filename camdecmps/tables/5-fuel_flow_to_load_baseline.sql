-- Table: camdecmps.fuel_flow_to_load_baseline

-- DROP TABLE camdecmps.fuel_flow_to_load_baseline;

CREATE TABLE IF NOT EXISTS camdecmps.fuel_flow_to_load_baseline
(
    fuel_flow_baseline_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    accuracy_test_number character varying(18) COLLATE pg_catalog."default",
    pei_test_number character varying(18) COLLATE pg_catalog."default",
    avg_fuel_flow_rate numeric(10,1),
    avg_load numeric(6,0),
    baseline_fuel_flow_load_ratio numeric(6,2),
    avg_hrly_hi_rate numeric(7,1),
    baseline_ghr numeric(6,0),
    nhe_cofiring numeric(4,0),
    nhe_ramping numeric(4,0),
    nhe_low_range numeric(4,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    fuel_flow_load_uom_cd character varying(7) COLLATE pg_catalog."default",
    ghr_uom_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_fuel_flow_to_load_baseline PRIMARY KEY (fuel_flow_baseline_id),
    CONSTRAINT fk_test_summary_fuel_flow_to_ FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_fuel_flow_to1 FOREIGN KEY (fuel_flow_load_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_fuel_flow_to2 FOREIGN KEY (ghr_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
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

-- Index: idx_ffload_baseline_001

-- DROP INDEX camdecmps.idx_ffload_baseline_001;

CREATE INDEX idx_ffload_baseline_001
    ON camdecmps.fuel_flow_to_load_baseline USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_fuel_flow_to_lo_fuel_flow

-- DROP INDEX camdecmps.idx_fuel_flow_to_lo_fuel_flow;

CREATE INDEX idx_fuel_flow_to_lo_fuel_flow
    ON camdecmps.fuel_flow_to_load_baseline USING btree
    (fuel_flow_load_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_fuel_flow_to_lo_ghr_uom_cd

-- DROP INDEX camdecmps.idx_fuel_flow_to_lo_ghr_uom_cd;

CREATE INDEX idx_fuel_flow_to_lo_ghr_uom_cd
    ON camdecmps.fuel_flow_to_load_baseline USING btree
    (ghr_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
