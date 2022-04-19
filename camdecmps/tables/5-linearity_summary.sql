-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.linearity_summary(
    lin_sum_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    mean_ref_value NUMERIC(13,3),
    calc_mean_ref_value NUMERIC(13,3),
    mean_measured_value NUMERIC(13,3),
    calc_mean_measured_value NUMERIC(13,3),
    percent_error NUMERIC(5,1),
    calc_percent_error NUMERIC(5,1),
    aps_ind NUMERIC(38,0),
    calc_aps_ind NUMERIC(38,0),
    gas_level_cd CHARACTER VARYING(7) NOT NULL,
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.linearity_summary
     IS 'Linearity check data and results summary.  Record Type 602.';
COMMENT ON COLUMN camdecmps.linearity_summary.lin_sum_id
     IS 'Unique identifier of a linearity summary record. ';
COMMENT ON COLUMN camdecmps.linearity_summary.test_sum_id
     IS 'Unique identifier of a test summary record. ';
COMMENT ON COLUMN camdecmps.linearity_summary.mean_ref_value
     IS 'Reported mean of referenced values. ';
COMMENT ON COLUMN camdecmps.linearity_summary.calc_mean_ref_value
     IS 'Reported mean of referenced values. ';
COMMENT ON COLUMN camdecmps.linearity_summary.mean_measured_value
     IS 'Reported mean of measured values. ';
COMMENT ON COLUMN camdecmps.linearity_summary.calc_mean_measured_value
     IS 'Reported mean of measured values. ';
COMMENT ON COLUMN camdecmps.linearity_summary.percent_error
     IS 'Reported percentage of error. ';
COMMENT ON COLUMN camdecmps.linearity_summary.calc_percent_error
     IS 'Reported percentage of error. ';
COMMENT ON COLUMN camdecmps.linearity_summary.aps_ind
     IS 'Used to indicate if the alternative performance specification (APS) is used. ';
COMMENT ON COLUMN camdecmps.linearity_summary.calc_aps_ind
     IS 'Used to indicate if the alternative performance specification (APS) is used. ';
COMMENT ON COLUMN camdecmps.linearity_summary.gas_level_cd
     IS 'Code used to identify calibration gas level. ';
COMMENT ON COLUMN camdecmps.linearity_summary.userid
     IS 'User account or source of data that added or updated record. ';
COMMENT ON COLUMN camdecmps.linearity_summary.add_date
     IS 'Date and time in which record was added. ';
COMMENT ON COLUMN camdecmps.linearity_summary.update_date
     IS 'Date and time in which record was last updated. ';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_linearity_summa_gas_level
ON camdecmps.linearity_summary
USING BTREE (gas_level_cd ASC);



CREATE INDEX idx_linearity_summary_001
ON camdecmps.linearity_summary
USING BTREE (test_sum_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.linearity_summary
ADD CONSTRAINT pk_linearity_summary PRIMARY KEY (lin_sum_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.linearity_summary
ADD CONSTRAINT fk_gas_level_cod_linearity_sum FOREIGN KEY (gas_level_cd) 
REFERENCES camdecmpsmd.gas_level_code (gas_level_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.linearity_summary
ADD CONSTRAINT fk_test_summary_linearity_sum FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;
