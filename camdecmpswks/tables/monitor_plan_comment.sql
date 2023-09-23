CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_plan_comment
(
    mon_plan_comment_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_comment character varying(4000) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    update_date timestamp without time zone
);
