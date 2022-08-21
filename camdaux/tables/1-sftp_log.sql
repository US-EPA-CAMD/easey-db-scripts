-- Table: camdaux.sftp_log

-- DROP TABLE camdaux.sftp_log;

CREATE TABLE camdaux.sftp_log
(
    id uuid NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    status_cd character varying COLLATE pg_catalog."default",
    details character varying COLLATE pg_catalog."default",
    errors character varying COLLATE pg_catalog."default",
    CONSTRAINT "sftp-log_pkey" PRIMARY KEY (id)
);