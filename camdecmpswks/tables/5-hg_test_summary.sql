-- Table: camdecmpswks.hg_test_summary

-- DROP TABLE camdecmpswks.hg_test_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.hg_test_summary
(
    hg_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    gas_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mean_measured_value numeric(13,3),
    mean_ref_value numeric(13,3),
    percent_error numeric(5,1),
    aps_ind numeric(38,0),
    calc_mean_measured_value numeric(13,3),
    calc_mean_ref_value numeric(13,3),
    calc_percent_error numeric(5,1),
    calc_aps_ind numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_hg_test_summary PRIMARY KEY (hg_test_sum_id),
    CONSTRAINT fk_hg_test_summary_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_hg_test_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);