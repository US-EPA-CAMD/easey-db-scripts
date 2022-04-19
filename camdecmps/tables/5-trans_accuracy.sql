-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.trans_accuracy(
    trans_ac_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    low_level_accuracy NUMERIC(5,1),
    mid_level_accuracy NUMERIC(5,1),
    high_level_accuracy NUMERIC(5,1),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE,
    low_level_accuracy_spec_cd CHARACTER VARYING(7),
    mid_level_accuracy_spec_cd CHARACTER VARYING(7),
    high_level_accuracy_spec_cd CHARACTER VARYING(7)
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.trans_accuracy
     IS 'Transmitter and transducer accuracy tests.  Record Type 628.';
COMMENT ON COLUMN camdecmps.trans_accuracy.trans_ac_id
     IS 'Unique identifier of transmitter transducer accuracy record. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.test_sum_id
     IS 'Unique identifier of a test summary record. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.low_level_accuracy
     IS 'Accuracy determination at low level. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.mid_level_accuracy
     IS 'Highest accuracy determination methodology for mid level. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.high_level_accuracy
     IS 'Accuracy determination at high level. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.userid
     IS 'User account or source of data that added or updated record. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.add_date
     IS 'Date and time in which record was added. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.update_date
     IS 'Date and time in which record was last updated. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.low_level_accuracy_spec_cd
     IS 'Code used to determine the accuracy determination methodology for low level. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.mid_level_accuracy_spec_cd
     IS 'Code used to identify the accuracy determination methodology for mid level. ';
COMMENT ON COLUMN camdecmps.trans_accuracy.high_level_accuracy_spec_cd
     IS 'Code used to identify the accuracy determination methodology for high level. ';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_trans_accuracy_001
ON camdecmps.trans_accuracy
USING BTREE (test_sum_id ASC);



CREATE INDEX idx_trans_accuracy_high_level
ON camdecmps.trans_accuracy
USING BTREE (high_level_accuracy_spec_cd ASC);



CREATE INDEX idx_trans_accuracy_low_level
ON camdecmps.trans_accuracy
USING BTREE (low_level_accuracy_spec_cd ASC);



CREATE INDEX idx_trans_accuracy_mid_level
ON camdecmps.trans_accuracy
USING BTREE (mid_level_accuracy_spec_cd ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.trans_accuracy
ADD CONSTRAINT pk_trans_accuracy PRIMARY KEY (trans_ac_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.trans_accuracy
ADD CONSTRAINT fk_accuracy_spec_trans_accura1 FOREIGN KEY (low_level_accuracy_spec_cd) 
REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.trans_accuracy
ADD CONSTRAINT fk_accuracy_spec_trans_accura2 FOREIGN KEY (mid_level_accuracy_spec_cd) 
REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.trans_accuracy
ADD CONSTRAINT fk_accuracy_spec_trans_accura3 FOREIGN KEY (high_level_accuracy_spec_cd) 
REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.trans_accuracy
ADD CONSTRAINT fk_test_summary_trans_accurac FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;
