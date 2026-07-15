CREATE TABLE IF NOT EXISTS camdmd.balance_code
(
    balance_cd varchar(7) NOT NULL,
    balance_description varchar(1000) NOT NULL,
    PRIMARY KEY (balance_cd)
);
COMMENT ON TABLE camdmd.balance_code
    IS 'Lookup table for balance cd.';
COMMENT ON COLUMN camdmd.balance_code.balance_cd
    IS 'Compliance balance type code.';
COMMENT ON COLUMN camdmd.balance_code.balance_description
    IS 'Full description of compliance balance type code.';