-- Table: camdecmpsmd.check_parameter_type_code

-- DROP TABLE camdecmpsmd.check_parameter_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_parameter_type_code
(
    chk_param_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    chk_param_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_check_parameter_type_code PRIMARY KEY (chk_param_type_cd)
);