-- Table: camdecmpsmd.system_parameter

-- DROP TABLE camdecmpsmd.system_parameter;

CREATE TABLE IF NOT EXISTS camdecmpsmd.system_parameter
(
    sys_param_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    sys_param_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    param_name1 character varying(50) COLLATE pg_catalog."default",
    param_value1 character varying(250) COLLATE pg_catalog."default",
    param_name2 character varying(50) COLLATE pg_catalog."default",
    param_value2 character varying(250) COLLATE pg_catalog."default",
    param_name3 character varying(50) COLLATE pg_catalog."default",
    param_value3 character varying(250) COLLATE pg_catalog."default",
    param_name4 character varying(50) COLLATE pg_catalog."default",
    param_value4 character varying(250) COLLATE pg_catalog."default",
    param_name5 character varying(50) COLLATE pg_catalog."default",
    param_value5 character varying(250) COLLATE pg_catalog."default",
    notes character varying(500) COLLATE pg_catalog."default",
    CONSTRAINT pk_system_parameter PRIMARY KEY (sys_param_id),
    CONSTRAINT fk_system_parameter_system_parameter_name FOREIGN KEY (sys_param_name)
        REFERENCES camdecmpsmd.system_parameter_name (sys_param_name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);