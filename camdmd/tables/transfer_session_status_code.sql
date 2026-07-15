CREATE TABLE IF NOT EXISTS camdmd.transfer_session_status_code
(
    trans_session_status_cd varchar(7) NOT NULL,
    trans_session_status_desc varchar(1000) NOT NULL,
    PRIMARY KEY (trans_session_status_cd)
);
COMMENT ON TABLE camdmd.transfer_session_status_code
    IS 'Lookup table for Transfer Session Status Codes.';
COMMENT ON COLUMN camdmd.transfer_session_status_code.trans_session_status_cd
    IS 'Transfer Session Status Code.';
COMMENT ON COLUMN camdmd.transfer_session_status_code.trans_session_status_desc
    IS 'Transfer Session Status Code description.';