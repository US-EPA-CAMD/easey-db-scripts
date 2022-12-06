-- Table: camdecmpsmd.op_date_code

-- DROP TABLE camdecmpsmd.op_date_code;

CREATE TABLE camdecmpsmd.op_date_code
(
    op_date_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    op_date_cd_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_op_date_code PRIMARY KEY (op_date_cd)
);