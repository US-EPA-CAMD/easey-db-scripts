CREATE TABLE IF NOT EXISTS camdecmpscalc.long_term_fuel_flow
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    ltff_id character varying(45) NOT NULL,
    calc_total_heat_input numeric(10,0)
);
