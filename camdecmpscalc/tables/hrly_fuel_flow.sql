CREATE TABLE IF NOT EXISTS camdecmpscalc.hrly_fuel_flow
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    hrly_fuel_flow_id character varying(45) NOT NULL,
    calc_mass_flow_rate numeric(10,1),
    calc_volumetric_flow_rate numeric(10,1),
    calc_appd_status character varying(75)
);
