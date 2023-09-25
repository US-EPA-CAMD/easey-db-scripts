CREATE TABLE IF NOT EXISTS camdecmpscalc.test_summary
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  test_sum_id character varying(45) NOT NULL,
    calc_gp_ind numeric(38,0),
    calc_test_result_cd character varying(7),
    calc_span_value numeric(13,3)
);
