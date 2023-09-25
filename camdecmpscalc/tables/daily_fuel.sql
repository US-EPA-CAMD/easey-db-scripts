CREATE TABLE IF NOT EXISTS camdecmpscalc.daily_fuel
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    daily_fuel_id character varying(45) NOT NULL,
    calc_fuel_carbon_burned numeric(13,1)
);
