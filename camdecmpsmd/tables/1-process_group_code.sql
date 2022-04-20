-- Table: camdecmpsmd.process_group_code

-- DROP TABLE camdecmpsmd.process_group_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.process_group_code
(
    process_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    process_group_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_process_group_code PRIMARY KEY (process_group_cd)
);