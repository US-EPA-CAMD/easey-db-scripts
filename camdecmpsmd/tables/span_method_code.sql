CREATE TABLE IF NOT EXISTS camdecmpsmd.span_method_code
(
    span_method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    span_method_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.span_method_code
    IS 'Lookup table of codes for method of calculating MPC/MEC/MPF.';

COMMENT ON COLUMN camdecmpsmd.span_method_code.span_method_cd
    IS 'Code used to identify the method used to calculate MPC/MEC/MPF. ';

COMMENT ON COLUMN camdecmpsmd.span_method_code.span_method_cd_description
    IS 'Description of lookup code. ';