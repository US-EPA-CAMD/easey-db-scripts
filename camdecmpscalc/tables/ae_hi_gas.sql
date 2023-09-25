CREATE TABLE IF NOT EXISTS camdecmpscalc.ae_hi_gas
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  ae_hi_gas_id character varying(45) NOT NULL,
    calc_gas_hi numeric(7,1)
);
