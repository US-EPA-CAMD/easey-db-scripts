-- Table: camdecmpsmd.parameter_group_override_code

-- DROP TABLE camdecmpsmd.parameter_group_override_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.parameter_group_override_code
(
    parameter_group_override_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    parameter_group_override_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_parameter_group_override_code PRIMARY KEY (parameter_group_override_cd)
);