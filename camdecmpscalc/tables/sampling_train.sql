CREATE TABLE IF NOT EXISTS camdecmpscalc.sampling_train
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    trap_train_id character varying(45) NOT NULL,
    calc_hg_concentration character varying(30),
    calc_percent_breakthrough numeric(6,1),
    calc_percent_spike_recovery numeric(4,1)
);
