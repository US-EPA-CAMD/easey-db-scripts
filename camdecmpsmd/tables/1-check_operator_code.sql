-- Table: camdecmpsmd.check_operator_code

-- DROP TABLE camdecmpsmd.check_operator_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_operator_code
(
    check_operator_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_operator_cd_name character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_check_operator_code PRIMARY KEY (check_operator_cd)
);