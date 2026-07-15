CREATE TABLE IF NOT EXISTS camdmd.transaction_status_code
(
    trans_status_cd varchar(7) NOT NULL,
    trans_status_description varchar(1000) NOT NULL,
    PRIMARY KEY (trans_status_cd)
);
COMMENT ON TABLE camdmd.transaction_status_code
    IS 'Lookup table for transaction status cd.';
COMMENT ON COLUMN camdmd.transaction_status_code.trans_status_cd
    IS 'Transaction status code.';
COMMENT ON COLUMN camdmd.transaction_status_code.trans_status_description
    IS 'Full description of transaction status.';