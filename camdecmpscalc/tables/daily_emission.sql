CREATE TABLE IF NOT EXISTS camdecmpscalc.daily_emission
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  daily_emission_id character varying(45) NOT NULL,
    calc_total_daily_emission numeric(10,1),
    calc_total_op_time numeric(4,2)
);
