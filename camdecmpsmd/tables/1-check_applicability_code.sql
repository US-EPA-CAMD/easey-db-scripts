-- Table: camdecmpsmd.check_applicability_code

-- DROP TABLE camdecmpsmd.check_applicability_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_applicability_code
(
    check_applicability_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_applicability_cd_name character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_check_applicability_code PRIMARY KEY (check_applicability_cd)
);