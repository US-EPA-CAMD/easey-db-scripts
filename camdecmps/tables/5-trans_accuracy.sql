-- Table: camdecmps.trans_accuracy

-- DROP TABLE camdecmps.trans_accuracy;

CREATE TABLE IF NOT EXISTS camdecmps.trans_accuracy
(
    trans_ac_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    low_level_accuracy numeric(5,1),
    mid_level_accuracy numeric(5,1),
    high_level_accuracy numeric(5,1),
    userid character varying(8) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    low_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    mid_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    high_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_trans_accuracy PRIMARY KEY (trans_ac_id),
    CONSTRAINT fk_accuracy_spec_trans_accura1 FOREIGN KEY (low_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_accuracy_spec_trans_accura2 FOREIGN KEY (mid_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_accuracy_spec_trans_accura3 FOREIGN KEY (high_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_trans_accurac FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
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

-- Index: idx_trans_accuracy_001

-- DROP INDEX camdecmps.idx_trans_accuracy_001;

CREATE INDEX idx_trans_accuracy_001
    ON camdecmps.trans_accuracy USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_trans_accuracy_high_level

-- DROP INDEX camdecmps.idx_trans_accuracy_high_level;

CREATE INDEX idx_trans_accuracy_high_level
    ON camdecmps.trans_accuracy USING btree
    (high_level_accuracy_spec_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_trans_accuracy_low_level

-- DROP INDEX camdecmps.idx_trans_accuracy_low_level;

CREATE INDEX idx_trans_accuracy_low_level
    ON camdecmps.trans_accuracy USING btree
    (low_level_accuracy_spec_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_trans_accuracy_mid_level

-- DROP INDEX camdecmps.idx_trans_accuracy_mid_level;

CREATE INDEX idx_trans_accuracy_mid_level
    ON camdecmps.trans_accuracy USING btree
    (mid_level_accuracy_spec_cd COLLATE pg_catalog."default" ASC NULLS LAST);
