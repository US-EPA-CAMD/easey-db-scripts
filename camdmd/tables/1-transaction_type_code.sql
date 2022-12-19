-- Table: camdmd.transaction_type_code

-- DROP TABLE camdmd.transaction_type_code;

CREATE TABLE IF NOT EXISTS camdmd.transaction_type_code
(
    trans_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    trans_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    allocation_ind numeric(1,0),
    CONSTRAINT pk_transaction_type_code PRIMARY KEY (trans_type_cd)
);

COMMENT ON TABLE camdmd.transaction_type_code
    IS 'Lookup table for transaction type cd.';

COMMENT ON COLUMN camdmd.transaction_type_code.trans_type_cd
    IS 'Code for type of transaction.';

COMMENT ON COLUMN camdmd.transaction_type_code.trans_type_description
    IS 'Full description of transaction type.';

COMMENT ON COLUMN camdmd.transaction_type_code.allocation_ind
    IS 'Indicates whether or not the transaction type is an allocation.';

-- Index: idx_trans_type_allocation

-- DROP INDEX camdmd.idx_trans_type_allocation;

CREATE INDEX IF NOT EXISTS idx_trans_type_allocation
    ON camdmd.transaction_type_code USING btree
    (allocation_ind ASC NULLS LAST);