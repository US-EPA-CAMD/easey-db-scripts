CREATE TABLE IF NOT EXISTS camdmd.account_status_code
(
    account_status_cd varchar(7) NOT NULL,
    account_status_description varchar(1000) NOT NULL,
    PRIMARY KEY (account_status_cd)
);
COMMENT ON TABLE camdmd.account_status_code
    IS 'Lookup table for account status cd.';
COMMENT ON COLUMN camdmd.account_status_code.account_status_cd
    IS 'Account status code.';
COMMENT ON COLUMN camdmd.account_status_code.account_status_description
    IS 'Account status description.';