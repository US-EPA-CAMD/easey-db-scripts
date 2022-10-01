-- Table: camdaux.sftp_failures

-- DROP TABLE camdaux.sftp_failures;

CREATE TABLE camdaux.sftp_failures
(
    id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    file_description character varying COLLATE pg_catalog."default",
    CONSTRAINT sftp_failures_pkey PRIMARY KEY (id)
);