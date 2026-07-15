CREATE TABLE IF NOT EXISTS camdmd.event_status_code
(
    event_status_cd varchar(7) NOT NULL,
    event_status_description varchar(1000) NOT NULL,
    PRIMARY KEY (event_status_cd)
);
COMMENT ON TABLE camdmd.event_status_code
    IS 'Lookup table containing codes that indicates the status for events.';
COMMENT ON COLUMN camdmd.event_status_code.event_status_cd
    IS 'The status code that indicates the status for events.';
COMMENT ON COLUMN camdmd.event_status_code.event_status_description
    IS 'The description of the status.';