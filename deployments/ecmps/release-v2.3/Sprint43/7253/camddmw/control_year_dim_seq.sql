CREATE SEQUENCE IF NOT EXISTS camddmw.control_year_dim_seq
    START WITH 1;

ALTER TABLE camddmw.control_year_dim ALTER COLUMN control_year_id SET DEFAULT nextval('camddmw.control_year_dim_seq');
