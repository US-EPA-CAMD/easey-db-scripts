CREATE SEQUENCE IF NOT EXISTS camddmw.owner_year_dim_seq
    START WITH 1;

ALTER TABLE camddmw.owner_year_dim ALTER COLUMN own_yr_id SET DEFAULT nextval('camddmw.owner_year_dim_seq');