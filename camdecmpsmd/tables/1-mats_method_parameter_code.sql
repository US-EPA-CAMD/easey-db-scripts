-- Table: camdecmpsmd.mats_method_parameter_code

-- DROP TABLE camdecmpsmd.mats_method_parameter_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.mats_method_parameter_code
(
    mats_method_parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mats_method_param_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_mats_method_parameter_code PRIMARY KEY (mats_method_parameter_cd)
);

COMMENT ON TABLE camdecmpsmd.mats_method_parameter_code
    IS 'Lookup table of MATS compliance parameters.';

COMMENT ON COLUMN camdecmpsmd.mats_method_parameter_code.mats_method_parameter_cd
    IS 'Code used to identify the MATS compliance parameter.';