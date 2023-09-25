CREATE TABLE IF NOT EXISTS camdecmpscalc.rata_traverse
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  rata_traverse_id character varying(45) NOT NULL,
    calc_vel numeric(6,2),
    calc_calc_vel numeric(6,2)
);
