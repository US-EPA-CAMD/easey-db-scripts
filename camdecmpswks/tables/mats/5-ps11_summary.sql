-- Table: camdecmpswks.ps11_summary

-- DROP TABLE camdecmpswks.ps11_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.ps11_summary
(
    ps11_sum_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    best_fit_model_cd character varying(7) NOT NULL,
    correlation_coefficient numeric(8,2),
    confidence_interval_half_range_percent numeric(3,0),
    tolerance_interval_half_range_percent numeric(3,0),
    correlation_equation character varying(200),
    userid character varying(25),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_ps11_summary PRIMARY KEY (ps11_sum_id),
    CONSTRAINT fk_ps11_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_ps11_summary_best_fit_model_code FOREIGN KEY (best_fit_model_cd)
        REFERENCES camdecmpsmd.best_fit_model_code (best_fit_model_cd) MATCH SIMPLE
);
