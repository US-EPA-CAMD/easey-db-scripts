-- Table: camdecmps.cycle_time_summary

-- DROP TABLE camdecmps.cycle_time_summary;

CREATE TABLE IF NOT EXISTS camdecmps.cycle_time_summary
(
    cycle_time_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    total_time numeric(2,0),
    calc_total_time numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_cycle_time_summary PRIMARY KEY (cycle_time_sum_id),
    CONSTRAINT fk_test_summary_cycle_time_su FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.cycle_time_summary
    IS 'Cycle time test summary data.  Record Type 621.';

COMMENT ON COLUMN camdecmps.cycle_time_summary.cycle_time_sum_id
    IS 'Unique identifier of cycle time summary record. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.total_time
    IS 'Reported time. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.calc_total_time
    IS 'Reported time. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_cycle_time_summary_001

-- DROP INDEX camdecmps.idx_cycle_time_summary_001;

CREATE INDEX IF NOT EXISTS idx_cycle_time_summary_001
    ON camdecmps.cycle_time_summary USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
