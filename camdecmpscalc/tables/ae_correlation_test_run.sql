CREATE TABLE IF NOT EXISTS camdecmpscalc.ae_correlation_test_run
(
    pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    ae_corr_test_run_id character varying(45) NOT NULL,
    calc_total_hi numeric(7,1),
    calc_hourly_hi_rate numeric(7,1)
);
