-- Table: camdecmpswks.trans_accuracy

-- DROP TABLE camdecmpswks.trans_accuracy;

CREATE TABLE IF NOT EXISTS camdecmpswks.trans_accuracy
(
    trans_ac_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    low_level_accuracy numeric(5,1),
    mid_level_accuracy numeric(5,1),
    high_level_accuracy numeric(5,1),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    low_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    mid_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    high_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_trans_accuracy PRIMARY KEY (trans_ac_id),
    CONSTRAINT fk_trans_accuracy_accuracy_spec_code_high FOREIGN KEY (high_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_trans_accuracy_accuracy_spec_code_low FOREIGN KEY (low_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_trans_accuracy_accuracy_spec_code_mid FOREIGN KEY (mid_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_trans_accuracy_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);