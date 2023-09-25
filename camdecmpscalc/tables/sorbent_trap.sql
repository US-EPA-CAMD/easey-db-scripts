CREATE TABLE IF NOT EXISTS camdecmpscalc.sorbent_trap
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    trap_id character varying(45) NOT NULL,
    calc_paired_trap_agreement numeric(5,2),
    calc_modc_cd character varying(7),
    calc_hg_concentration character varying(30)
);
