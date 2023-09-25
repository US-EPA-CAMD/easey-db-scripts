CREATE TABLE IF NOT EXISTS camdecmpscalc.weekly_test_summary
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    weekly_test_sum_id character varying(45) NOT NULL,
    calc_test_result_cd character varying(7)
);
