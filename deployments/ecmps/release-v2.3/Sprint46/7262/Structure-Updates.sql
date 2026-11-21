
CREATE SEQUENCE IF NOT EXISTS camddmw.rep_year_dim_seq START WITH 1;

ALTER TABLE camddmw.rep_year_dim ALTER COLUMN rep_yr_id SET DEFAULT nextval('camddmw.rep_year_dim_seq');

ALTER SEQUENCE camddmw.rep_year_dim_seq OWNED BY camddmw.rep_year_dim.rep_yr_id;