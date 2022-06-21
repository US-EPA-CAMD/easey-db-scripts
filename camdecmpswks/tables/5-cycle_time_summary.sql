-- Table: camdecmpswks.cycle_time_summary

-- DROP TABLE camdecmpswks.cycle_time_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.cycle_time_summary
(
    cycle_time_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    total_time numeric(2,0),
    calc_total_time numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_cycle_time_summary PRIMARY KEY (cycle_time_sum_id),
    CONSTRAINT fk_cycle_time_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_cycle_time_summary_001

-- -- DROP INDEX camdecmpswks.idx_cycle_time_summary_001;

-- CREATE INDEX idx_cycle_time_summary_001
--     ON camdecmpswks.cycle_time_summary USING btree
--     (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
