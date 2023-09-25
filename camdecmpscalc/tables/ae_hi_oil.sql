CREATE TABLE IF NOT EXISTS camdecmpscalc.ae_hi_oil
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  ae_hi_oil_id character varying(45) NOT NULL,
    calc_oil_hi numeric(7,1),
    calc_oil_mass numeric(10,1)
);
