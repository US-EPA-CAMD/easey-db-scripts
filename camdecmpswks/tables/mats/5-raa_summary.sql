-- Table: camdecmpswks.raa_summary

-- DROP TABLE camdecmpswks.raa_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.raa_summary
(
    raa_sum_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    ref_method_cd character varying(7) NOT NULL,
    mean_cem_value numeric(13,3),
    mean_ref_value numeric(13,3),
    relative_accuracy numeric(5,1),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_raa_summary PRIMARY KEY (raa_sum_id),
    CONSTRAINT fk_raa_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_raa_summary_ref_method_code FOREIGN KEY (ref_method_cd)
        REFERENCES camdecmpsmd.ref_method_code (ref_method_cd) MATCH SIMPLE,
    CONSTRAINT ck_raa_summary_ref_method_code CHECK(ref_method_cd = ANY(ARRAY['26A', '320', '321', 'D634812']))
);
