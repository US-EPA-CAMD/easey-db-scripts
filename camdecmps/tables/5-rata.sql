-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.rata(
    rata_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    rata_frequency_cd CHARACTER VARYING(7),
    calc_rata_frequency_cd CHARACTER VARYING(7),
    relative_accuracy NUMERIC(5,2),
    calc_relative_accuracy NUMERIC(5,2),
    overall_bias_adj_factor NUMERIC(5,3),
    calc_overall_bias_adj_factor NUMERIC(5,3),
    num_load_level NUMERIC(1,0),
    calc_num_load_level NUMERIC(1,0),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.rata
     IS 'Relative Accuracy Test Audit (RATA) and bias test overall results.  Record Type  611.';
COMMENT ON COLUMN camdecmps.rata.rata_id
     IS 'Unique identifier of a RATA record. ';
COMMENT ON COLUMN camdecmps.rata.test_sum_id
     IS 'Unique identifier of a test summary record. ';
COMMENT ON COLUMN camdecmps.rata.rata_frequency_cd
     IS 'Code used to identify RATA frequency. ';
COMMENT ON COLUMN camdecmps.rata.calc_rata_frequency_cd
     IS 'Calculated code used to identify RATA frequency. ';
COMMENT ON COLUMN camdecmps.rata.relative_accuracy
     IS 'Reported relative accuracy. ';
COMMENT ON COLUMN camdecmps.rata.calc_relative_accuracy
     IS 'Reported relative accuracy. ';
COMMENT ON COLUMN camdecmps.rata.overall_bias_adj_factor
     IS 'Reported overall bias adjustment factor for this test. ';
COMMENT ON COLUMN camdecmps.rata.calc_overall_bias_adj_factor
     IS 'Reported overall bias adjustment factor for this test. ';
COMMENT ON COLUMN camdecmps.rata.num_load_level
     IS 'Number of load or operating levels comprising test. ';
COMMENT ON COLUMN camdecmps.rata.calc_num_load_level
     IS 'Number of load or operating levels comprising test. ';
COMMENT ON COLUMN camdecmps.rata.userid
     IS 'User account or source of data that added or updated record. ';
COMMENT ON COLUMN camdecmps.rata.add_date
     IS 'Date and time in which record was added. ';
COMMENT ON COLUMN camdecmps.rata.update_date
     IS 'Date and time in which record was last updated. ';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_rata_001
ON camdecmps.rata
USING BTREE (test_sum_id ASC);



CREATE INDEX idx_rata_calc_rata
ON camdecmps.rata
USING BTREE (calc_rata_frequency_cd ASC);



CREATE INDEX idx_rata_rata_frequ
ON camdecmps.rata
USING BTREE (rata_frequency_cd ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.rata
ADD CONSTRAINT pk_rata PRIMARY KEY (rata_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.rata
ADD CONSTRAINT fk_rata_frequenc_rata FOREIGN KEY (rata_frequency_cd) 
REFERENCES camdecmpsmd.rata_frequency_code (rata_frequency_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.rata
ADD CONSTRAINT fk_rata_frequenc_rata2 FOREIGN KEY (calc_rata_frequency_cd) 
REFERENCES camdecmpsmd.rata_frequency_code (rata_frequency_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.rata
ADD CONSTRAINT fk_test_summary_rata FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;
