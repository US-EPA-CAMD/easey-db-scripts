CREATE TABLE IF NOT EXISTS camdmd.transaction_type_code
(
    trans_type_cd varchar(7) NOT NULL,
    trans_type_description varchar(1000) NOT NULL,
    allocation_ind numeric(1,0) NOT NULL DEFAULT 0,
    PRIMARY KEY (trans_type_cd)
);
COMMENT ON TABLE camdmd.transaction_type_code
    IS 'Lookup table for transaction type cd.';
COMMENT ON COLUMN camdmd.transaction_type_code.trans_type_cd
    IS 'Code for type of transaction.';
COMMENT ON COLUMN camdmd.transaction_type_code.trans_type_description
    IS 'Full description of transaction type.';
COMMENT ON COLUMN camdmd.transaction_type_code.allocation_ind
    IS 'Indicates whether or not the transaction type is an allocation.';