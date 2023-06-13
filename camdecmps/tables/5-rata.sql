-- Table: camdecmps.rata

-- DROP TABLE camdecmps.rata;

CREATE TABLE IF NOT EXISTS camdecmps.rata
(
    rata_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rata_frequency_cd character varying(7) COLLATE pg_catalog."default",
    calc_rata_frequency_cd character varying(7) COLLATE pg_catalog."default",
    relative_accuracy numeric(5,2),
    calc_relative_accuracy numeric(5,2),
    overall_bias_adj_factor numeric(5,3),
    calc_overall_bias_adj_factor numeric(5,3),
    num_load_level numeric(1,0),
    calc_num_load_level numeric(1,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_rata PRIMARY KEY (rata_id),
    CONSTRAINT fk_rata_rata_frequency_code FOREIGN KEY (rata_frequency_cd)
        REFERENCES camdecmpsmd.rata_frequency_code (rata_frequency_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rata_rata_frequency_code_calc FOREIGN KEY (calc_rata_frequency_cd)
        REFERENCES camdecmpsmd.rata_frequency_code (rata_frequency_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rata_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
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

-- Index: idx_rata_001

-- DROP INDEX camdecmps.idx_rata_001;

CREATE INDEX IF NOT EXISTS idx_rata_001
    ON camdecmps.rata USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_rata_calc_rata

-- DROP INDEX camdecmps.idx_rata_calc_rata;

CREATE INDEX IF NOT EXISTS idx_rata_calc_rata
    ON camdecmps.rata USING btree
    (calc_rata_frequency_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_rata_rata_frequ

-- DROP INDEX camdecmps.idx_rata_rata_frequ;

CREATE INDEX IF NOT EXISTS idx_rata_rata_frequ
    ON camdecmps.rata USING btree
    (rata_frequency_cd COLLATE pg_catalog."default" ASC NULLS LAST);
