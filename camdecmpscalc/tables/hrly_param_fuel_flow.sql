CREATE TABLE IF NOT EXISTS camdecmpscalc.hrly_param_fuel_flow
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    hrly_param_ff_id character varying(45) NOT NULL,
    calc_param_val_fuel numeric(13,5),
    calc_appe_status character varying(75)
);
