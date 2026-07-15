CREATE TABLE IF NOT EXISTS camdmd.operating_status_code
(
    op_status_cd varchar(7) NOT NULL,
    op_status_description varchar(1000) NOT NULL,
    PRIMARY KEY (op_status_cd)
);
COMMENT ON TABLE camdmd.operating_status_code
    IS 'Operating status codes for units.';
COMMENT ON COLUMN camdmd.operating_status_code.op_status_cd
    IS 'UNIT operating status (retired or operating) code.';
COMMENT ON COLUMN camdmd.operating_status_code.op_status_description
    IS 'Description of operating status codes.';