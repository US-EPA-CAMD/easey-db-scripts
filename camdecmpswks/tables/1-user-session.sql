-- Table: camdecmpswks.user_session

-- DROP TABLE camdecmpswks.user_session;

CREATE TABLE camdecmpswks.user_session
(
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    session_id character varying(45) COLLATE pg_catalog."default",
    security_token character varying(50000) COLLATE pg_catalog."default",
    token_expiration timestamp without time zone NOT NULL DEFAULT (CURRENT_TIMESTAMP + '00:20:00'::interval),
    last_login_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_session_pkey PRIMARY KEY (userid)
);
-- Index: token_index

-- DROP INDEX camdecmpswks.token_index;

CREATE INDEX token_index
    ON camdecmpswks.user_session USING btree
    (security_token COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;