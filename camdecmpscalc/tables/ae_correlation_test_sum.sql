CREATE TABLE IF NOT EXISTS camdecmpscalc.ae_correlation_test_sum
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  ae_corr_test_sum_id character varying(45) NOT NULL,
    calc_mean_ref_value numeric(8,3),
    calc_avg_hrly_hi_rate numeric(7,1)
);
