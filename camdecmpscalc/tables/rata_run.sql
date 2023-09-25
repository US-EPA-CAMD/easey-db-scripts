CREATE TABLE IF NOT EXISTS camdecmpscalc.rata_run
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  rata_run_id character varying(45) NOT NULL,
    calc_rata_ref_value numeric(15,5)
);
