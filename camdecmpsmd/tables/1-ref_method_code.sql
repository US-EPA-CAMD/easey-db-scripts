-- Table: camdecmpsmd.ref_method_code

-- DROP TABLE camdecmpsmd.ref_method_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.ref_method_code
(
    ref_method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    ref_method_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(9) COLLATE pg_catalog."default",
    CONSTRAINT pk_ref_method_code PRIMARY KEY (ref_method_cd)
);

COMMENT ON TABLE camdecmpsmd.ref_method_code
    IS 'Lookup table of reference methods.';

COMMENT ON COLUMN camdecmpsmd.ref_method_code.ref_method_cd
    IS 'Code used to identify a reference method. ';

COMMENT ON COLUMN camdecmpsmd.ref_method_code.ref_method_cd_description
    IS 'Description of reference method code. ';

COMMENT ON COLUMN camdecmpsmd.ref_method_code.parameter_cd
    IS 'Unique code value for a lookup table.';

-- Index: idx_ref_method_cod_parameter

-- DROP INDEX camdecmpsmd.idx_ref_method_cod_parameter;

CREATE INDEX IF NOT EXISTS idx_ref_method_cod_parameter
    ON camdecmpsmd.ref_method_code USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
