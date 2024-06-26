CREATE TABLE IF NOT EXISTS camdecmpswks.user_check_out_new (
    facility_id integer NOT NULL,
    checked_out_on timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    checked_out_by text COLLATE pg_catalog."default" NOT NULL,
    last_activity timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

