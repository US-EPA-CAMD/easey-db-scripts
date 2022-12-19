-- Table: camdecmpswks.ae_correlation_test_run

-- DROP TABLE camdecmpswks.ae_correlation_test_run;

CREATE TABLE IF NOT EXISTS camdecmpswks.ae_correlation_test_run
(
    ae_corr_test_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    ae_corr_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    run_num numeric(2,0) NOT NULL,
    ref_value numeric(8,3),
    response_time numeric(3,0),
    total_hi numeric(7,1),
    calc_total_hi numeric(7,1),
    hourly_hi_rate numeric(7,1),
    calc_hourly_hi_rate numeric(7,1),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_ae_correlation_test_run PRIMARY KEY (ae_corr_test_run_id),
    CONSTRAINT fk_ae_correlation_test_run_ae_correlation_test_sum FOREIGN KEY (ae_corr_test_sum_id)
        REFERENCES camdecmpswks.ae_correlation_test_sum (ae_corr_test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);