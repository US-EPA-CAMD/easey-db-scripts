-- Table: camdecmps.flow_to_load_check

-- DROP TABLE camdecmps.flow_to_load_check;

CREATE TABLE IF NOT EXISTS camdecmps.flow_to_load_check
(
    flow_load_check_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_basis_cd character varying(7) COLLATE pg_catalog."default",
    avg_abs_pct_diff numeric(5,1),
    num_hrs numeric(4,0),
    nhe_fuel numeric(4,0),
    nhe_ramping numeric(4,0),
    nhe_bypass numeric(4,0),
    nhe_pre_rata numeric(4,0),
    nhe_test numeric(4,0),
    nhe_main_bypass numeric(4,0),
    bias_adjusted_ind numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    op_level_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_flow_to_load_check PRIMARY KEY (flow_load_check_id),
    CONSTRAINT fk_operating_lev_flow_to_load FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_basis_flow_to_load_che FOREIGN KEY (test_basis_cd)
        REFERENCES camdecmpsmd.test_basis_code (test_basis_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_flow_to_l103 FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.flow_to_load_check
    IS 'Quarterly flow-to-load ratio or gross heat rate check data.  Record Type 606.';

COMMENT ON COLUMN camdecmps.flow_to_load_check.flow_load_check_id
    IS 'Unique identifier of flow load check record. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.test_basis_cd
    IS 'Code used to identify the test basis (Q-flow-to-load ratio; H-gross heat rate). ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.avg_abs_pct_diff
    IS 'Average absolute percent difference between reference ration (GHR) and hourly ratios (or GHR values). ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.num_hrs
    IS 'Number of hours used in quarterly flow-to-load or GHR analysis. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.nhe_fuel
    IS 'Number of hours excluded for different type of fuel. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.nhe_ramping
    IS 'Number of hours excluded for load ramping up or down. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.nhe_bypass
    IS 'Number of hours excluded for scrubber bypass. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.nhe_pre_rata
    IS 'Number of hours excluded preceding a normal load flow RATA. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.nhe_test
    IS 'Number of excluded hours preceding a successful diagnostic test, following a documented monitor repair, or following a major component replacement. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.nhe_main_bypass
    IS 'Number of hours excluded for flue gases discharging simultaneously through a main stack and bypass stack. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.bias_adjusted_ind
    IS 'Used to Indicate whether the BAF was applied to reported flow values. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.flow_to_load_check.op_level_cd
    IS 'Code used to identify the operating level. ';

-- Index: idx_flow_to_load_ch_op_level_c

-- DROP INDEX camdecmps.idx_flow_to_load_ch_op_level_c;

CREATE INDEX idx_flow_to_load_ch_op_level_c
    ON camdecmps.flow_to_load_check USING btree
    (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_flow_to_load_ch_test_basis

-- DROP INDEX camdecmps.idx_flow_to_load_ch_test_basis;

CREATE INDEX idx_flow_to_load_ch_test_basis
    ON camdecmps.flow_to_load_check USING btree
    (test_basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_flow_to_load_check_001

-- DROP INDEX camdecmps.idx_flow_to_load_check_001;

CREATE INDEX idx_flow_to_load_check_001
    ON camdecmps.flow_to_load_check USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
