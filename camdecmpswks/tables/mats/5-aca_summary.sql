-- Table: camdecmpswks.aca_summary

-- DROP TABLE camdecmpswks.aca_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.aca_summary
(
    aca_sum_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    reference_level_cd character varying(7) NOT NULL,
    mean_measured_value numeric(13,3),
    mean_ref_value numeric(13,3),
    percent_error numeric(5,1),
    aps_ind numeric(1,0),
    userid character varying(25),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_aca_summary PRIMARY KEY (aca_sum_id),
    CONSTRAINT fk_aca_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_aca_summary_reference_level_code FOREIGN KEY (reference_level_cd)
        REFERENCES camdecmpsmd.reference_level_code (reference_level_cd) MATCH SIMPLE
);
