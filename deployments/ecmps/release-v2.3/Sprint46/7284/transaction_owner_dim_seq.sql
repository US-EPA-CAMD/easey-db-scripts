CREATE SEQUENCE IF NOT EXISTS camddmw.transaction_owner_dim_seq
    START WITH 1;

ALTER TABLE camddmw.transaction_owner_dim ALTER COLUMN transaction_owner_unique_id SET DEFAULT nextval('camddmw.transaction_owner_dim_seq');
