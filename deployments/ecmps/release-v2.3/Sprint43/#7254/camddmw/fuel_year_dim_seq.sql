CREATE SEQUENCE IF NOT EXISTS camddmw.fuel_year_dim_seq
    START WITH 1;

ALTER TABLE camddmw.fuel_year_dim ALTER COLUMN fuel_yr_dim SET DEFAULT nextval('camddmw.fuel_year_dim_seq');
