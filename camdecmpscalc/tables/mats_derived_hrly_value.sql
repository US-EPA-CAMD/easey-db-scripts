CREATE TABLE IF NOT EXISTS camdecmpscalc.mats_derived_hrly_value
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    mats_dhv_id character varying(45) NOT NULL,
    calc_unadjusted_hrly_value character varying(30),
    calc_pct_diluent numeric(5,1),
    calc_pct_moisture numeric(5,1)
);
