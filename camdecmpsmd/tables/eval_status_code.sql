CREATE TABLE IF NOT EXISTS camdecmpsmd.eval_status_code
(
    eval_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    eval_status_cd_description character varying(100) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.eval_status_code
    IS 'Lookup table containing evaluation status codes.';

COMMENT ON COLUMN camdecmpsmd.eval_status_code.eval_status_cd
    IS 'Identifies the evaluation status.';

COMMENT ON COLUMN camdecmpsmd.eval_status_code.eval_status_cd_description
    IS 'Full description of evaluation status.';
