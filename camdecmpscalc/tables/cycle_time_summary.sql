CREATE TABLE IF NOT EXISTS camdecmpscalc.cycle_time_summary
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  cycle_time_sum_id character varying(45) NOT NULL,
    calc_total_time numeric(2,0)
);