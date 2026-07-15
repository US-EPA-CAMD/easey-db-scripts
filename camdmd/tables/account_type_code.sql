CREATE TABLE IF NOT EXISTS camdmd.account_type_code
(
    account_type_cd varchar(7) NOT NULL,
    account_type_group_cd varchar(7) NOT NULL,
    account_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (account_type_cd)
);
COMMENT ON TABLE camdmd.account_type_code
    IS 'Lookup table for account type code.';
COMMENT ON COLUMN camdmd.account_type_code.account_type_cd
    IS 'Account type code.';
COMMENT ON COLUMN camdmd.account_type_code.account_type_group_cd
    IS 'Account type group code.';
COMMENT ON COLUMN camdmd.account_type_code.account_type_description
    IS 'Account type description.';