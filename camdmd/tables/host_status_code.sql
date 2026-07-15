CREATE TABLE IF NOT EXISTS camdmd.host_status_code
(
    host_status_cd varchar(7) NOT NULL,
    host_status_description varchar(1000) NOT NULL,
    PRIMARY KEY (host_status_cd)
);
COMMENT ON TABLE camdmd.host_status_code
    IS 'Table for the ECMPS host status codes';
COMMENT ON COLUMN camdmd.host_status_code.host_status_cd
    IS 'Code of the ECMP host status';
COMMENT ON COLUMN camdmd.host_status_code.host_status_description
    IS 'Description for the Code of the ECMP host status';