CREATE TABLE IF NOT EXISTS camdecmpsmd.span_scale_code
(
    span_scale_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    span_scale_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.span_scale_code
    IS 'Lookup table of codes for scale.';

COMMENT ON COLUMN camdecmpsmd.span_scale_code.span_scale_cd
    IS 'Code used to identify the span scale. ';

COMMENT ON COLUMN camdecmpsmd.span_scale_code.span_scale_cd_description
    IS 'Description of lookup code. ';