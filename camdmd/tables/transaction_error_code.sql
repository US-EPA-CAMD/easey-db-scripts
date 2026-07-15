CREATE TABLE IF NOT EXISTS camdmd.transaction_error_code
(
    trans_error_cd varchar(7) NOT NULL,
    trans_error_description varchar(1000) NOT NULL,
    trans_error_message varchar(1000),
    admin_override_ind numeric(1,0) NOT NULL DEFAULT 0,
    indu_override_ind numeric(1,0) NOT NULL DEFAULT 0,
    PRIMARY KEY (trans_error_cd)
);
COMMENT ON TABLE camdmd.transaction_error_code
    IS 'Lookup table for transaction error cds.';
COMMENT ON COLUMN camdmd.transaction_error_code.trans_error_cd
    IS 'Transaction error code.';
COMMENT ON COLUMN camdmd.transaction_error_code.trans_error_description
    IS 'Full description of transaction error code.';
COMMENT ON COLUMN camdmd.transaction_error_code.admin_override_ind
    IS 'Indicates if the error can be overridden by Admin users.';
COMMENT ON COLUMN camdmd.transaction_error_code.indu_override_ind
    IS 'Indicates if the error can be overridden by Industry users.';