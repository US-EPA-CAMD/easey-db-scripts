-- Table: camdecmpsmd.configuration_type_code

-- DROP TABLE camdecmpsmd.configuration_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.configuration_type_code
(
    config_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    config_type_cd_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_configuration_type_code PRIMARY KEY (config_type_cd)
);