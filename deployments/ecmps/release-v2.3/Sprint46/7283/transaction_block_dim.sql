CREATE SEQUENCE camddmw.transaction_block_dim_seq
    START WITH 1;

ALTER TABLE camddmw.transaction_block_dim ALTER COLUMN transaction_block_id SET DEFAULT nextval('camddmw.transaction_block_dim_seq');
