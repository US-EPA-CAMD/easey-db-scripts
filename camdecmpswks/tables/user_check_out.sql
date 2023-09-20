CREATE TABLE IF NOT EXISTS camdecmpswks.user_check_out
(
    facility_id integer NOT NULL,
    mon_plan_id text COLLATE pg_catalog."default" NOT NULL,
    checked_out_on timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    checked_out_by text COLLATE pg_catalog."default" NOT NULL,
    last_activity timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);
