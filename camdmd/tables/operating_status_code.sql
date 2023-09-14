CREATE TABLE IF NOT EXISTS camdmd.operating_status_code
(
    op_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    op_status_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdmd.operating_status_code
    IS 'Operating status codes for units.';

COMMENT ON COLUMN camdmd.operating_status_code.op_status_cd
    IS 'UNIT operating status (retired or operating) code.';

COMMENT ON COLUMN camdmd.operating_status_code.op_status_description
    IS 'Description of operating status codes.';
