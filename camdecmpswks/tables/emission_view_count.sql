CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_count
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    dataset_cd character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    count numeric(38,0) NOT NULL
);