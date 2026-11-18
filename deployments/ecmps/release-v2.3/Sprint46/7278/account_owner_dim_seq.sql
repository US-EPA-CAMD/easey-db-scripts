CREATE SEQUENCE IF NOT EXISTS camddmw.account_owner_dim_seq
    START WITH 1;

ALTER TABLE camddmw.account_owner_dim ALTER COLUMN account_owner_unique_id SET DEFAULT nextval('camddmw.account_owner_dim_seq');
