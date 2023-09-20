CREATE TABLE IF NOT EXISTS camdecmps.daily_backstop
(
    daily_backstop_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    unit_id numeric(38,0) NOT NULL,
    op_date date NOT NULL,
    daily_noxm numeric(10,1) NOT NULL,
    daily_hit numeric(10,1) NOT NULL,
    daily_avg_noxr numeric(7,3),
    daily_noxm_exceed numeric(10,1) NOT NULL,
    cumulative_os_noxm_exceed numeric(13,1),
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);
