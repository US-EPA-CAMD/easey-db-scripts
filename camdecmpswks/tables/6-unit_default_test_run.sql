-- Table: camdecmpswks.unit_default_test_run

-- DROP TABLE camdecmpswks.unit_default_test_run;

CREATE TABLE IF NOT EXISTS camdecmpswks.unit_default_test_run
(
    unit_default_test_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_default_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    op_level_num numeric(2,0),
    run_num numeric(2,0) NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    response_time numeric(3,0),
    ref_value numeric(8,3),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    run_used_ind numeric(38,0),
    CONSTRAINT pk_unit_default_test_run PRIMARY KEY (unit_default_test_run_id),
    CONSTRAINT fk_unit_default_test_run_unit_default_test FOREIGN KEY (unit_default_test_sum_id)
        REFERENCES camdecmpswks.unit_default_test (unit_default_test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_unit_default_te_unit_defau

-- -- DROP INDEX camdecmpswks.idx_unit_default_te_unit_defau;

-- CREATE INDEX idx_unit_default_te_unit_defau
--     ON camdecmpswks.unit_default_test_run USING btree
--     (unit_default_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
