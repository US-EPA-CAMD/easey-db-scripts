CREATE TABLE IF NOT EXISTS camdecmpscalc.sampling_train_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    trap_train_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    sfsr_total_count numeric(38,0),
    sfsr_deviated_count numeric(38,0),
    gfm_total_count numeric(38,0),
    gfm_not_available_count numeric(38,0)
);
