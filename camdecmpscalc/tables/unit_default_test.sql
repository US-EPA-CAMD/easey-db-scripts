CREATE TABLE IF NOT EXISTS camdecmpscalc.unit_default_test
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    unit_default_test_sum_id character varying(45) NOT NULL,
    calc_nox_default_rate numeric(6,3)
);
