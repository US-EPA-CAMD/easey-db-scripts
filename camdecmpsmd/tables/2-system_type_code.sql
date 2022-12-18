-- Table: camdecmpsmd.system_type_code

-- DROP TABLE camdecmpsmd.system_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.system_type_code
(
    sys_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sys_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_system_type_code PRIMARY KEY (sys_type_cd),
    CONSTRAINT fk_parameter_cod_system_type_c FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsmd.system_type_code
    IS 'Lookup table of types of monitoring systems.';

COMMENT ON COLUMN camdecmpsmd.system_type_code.sys_type_cd
    IS 'Code used to identify the type (parameter) of the system. ';

COMMENT ON COLUMN camdecmpsmd.system_type_code.sys_type_description
    IS 'Description of monitoring system code. ';

COMMENT ON COLUMN camdecmpsmd.system_type_code.parameter_cd
    IS 'Code used to identify the parameter. ';

-- Index: idx_system_type_cod_parameter

-- DROP INDEX camdecmpsmd.idx_system_type_cod_parameter;

CREATE INDEX IF NOT EXISTS idx_system_type_cod_parameter
    ON camdecmpsmd.system_type_code USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
