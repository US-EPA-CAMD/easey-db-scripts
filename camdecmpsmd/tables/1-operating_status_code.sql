-- Table: camdecmpsmd.operating_status_code

-- DROP TABLE camdecmpsmd.operating_status_code;

CREATE TABLE camdecmpsmd.operating_status_code
(
    op_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    op_status_cd_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_operating_status_code PRIMARY KEY (op_status_cd)
);