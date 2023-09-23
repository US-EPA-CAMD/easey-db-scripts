CREATE TABLE IF NOT EXISTS camdecmpswks.user_session
(
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    session_id character varying(45) COLLATE pg_catalog."default",
    security_token text COLLATE pg_catalog."default",
    facilities text COLLATE pg_catalog."default",
    token_expiration timestamp without time zone NOT NULL DEFAULT (CURRENT_TIMESTAMP + '00:20:00'::interval),
    last_login_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_activity timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);