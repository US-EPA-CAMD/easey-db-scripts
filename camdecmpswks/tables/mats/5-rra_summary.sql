-- Table: camdecmpswks.rra_summary

-- DROP TABLE camdecmpswks.rra_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.rra_summary
(
    rra_sum_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    best_fit_model_cd character varying(7) NOT NULL,
    correlation_equation character varying(200),
    max_correlation_response numeric(8,3),
    min_correlation_response numeric(8,3),
    runs_within_regression_criteria numeric(2,0),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_rra_summary PRIMARY KEY (rra_sum_id),
    CONSTRAINT fk_rra_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_rra_summary_best_fit_model_code FOREIGN KEY (best_fit_model_cd)
        REFERENCES camdecmpsmd.best_fit_model_code (best_fit_model_cd) MATCH SIMPLE
);
