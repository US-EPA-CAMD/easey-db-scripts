CREATE TABLE IF NOT EXISTS camdecmpsmd.component_type_code
(
    component_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    component_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    span_indicator numeric(38,0),
    parameter_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.component_type_code
    IS 'Lookup table of component type codes.  Record Type 510.';

COMMENT ON COLUMN camdecmpsmd.component_type_code.component_type_cd
    IS 'Code used to identify the component type. ';

COMMENT ON COLUMN camdecmpsmd.component_type_code.component_type_cd_description
    IS 'Description of lookup code. ';

COMMENT ON COLUMN camdecmpsmd.component_type_code.span_indicator
    IS 'Indicates whether a condition is true or false. ';

COMMENT ON COLUMN camdecmpsmd.component_type_code.parameter_cd
    IS 'Code used to identify the parameter. ';