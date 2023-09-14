CREATE TABLE IF NOT EXISTS camdecmpsmd.system_type_code
(
    sys_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sys_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.system_type_code
    IS 'Lookup table of types of monitoring systems.';

COMMENT ON COLUMN camdecmpsmd.system_type_code.sys_type_cd
    IS 'Code used to identify the type (parameter) of the system. ';

COMMENT ON COLUMN camdecmpsmd.system_type_code.sys_type_description
    IS 'Description of monitoring system code. ';

COMMENT ON COLUMN camdecmpsmd.system_type_code.parameter_cd
    IS 'Code used to identify the parameter. ';
