-- DROP TABLE IF EXISTS camdaux.sftp_failures;

CREATE TABLE IF NOT EXISTS camdaux.sftp_failures
(
    id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    file_description character varying COLLATE pg_catalog."default",
    CONSTRAINT sftp_failures_pkey PRIMARY KEY (id)
)