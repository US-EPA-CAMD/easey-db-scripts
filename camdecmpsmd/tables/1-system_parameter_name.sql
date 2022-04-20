-- Table: camdecmpsmd.system_parameter_name

-- DROP TABLE camdecmpsmd.system_parameter_name;

CREATE TABLE IF NOT EXISTS camdecmpsmd.system_parameter_name
(
    sys_param_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    sys_param_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_system_parameter_name PRIMARY KEY (sys_param_name)
);