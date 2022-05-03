-- Table: camdecmpswks.test_qualification

-- DROP TABLE camdecmpswks.test_qualification;

CREATE TABLE IF NOT EXISTS camdecmpswks.test_qualification
(
    test_qualification_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_claim_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    hi_load_pct numeric(5,1),
    mid_load_pct numeric(5,1),
    low_load_pct numeric(5,1),
    begin_date date,
    end_date date,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_test_qualification PRIMARY KEY (test_qualification_id),
    CONSTRAINT fk_test_qualification_test_claim_code FOREIGN KEY (test_claim_cd)
        REFERENCES camdecmpsmd.test_claim_code (test_claim_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_qualification_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_test_qualificat_test_claim

-- -- DROP INDEX camdecmpswks.idx_test_qualificat_test_claim;

-- CREATE INDEX idx_test_qualificat_test_claim
--     ON camdecmpswks.test_qualification USING btree
--     (test_claim_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_qualification_001

-- -- DROP INDEX camdecmpswks.idx_test_qualification_001;

-- CREATE INDEX idx_test_qualification_001
--     ON camdecmpswks.test_qualification USING btree
--     (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
