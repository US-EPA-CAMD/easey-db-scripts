-- Table: camddmw.quarter_unit_data_log

-- DROP TABLE camddmw.quarter_unit_data_log;

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_log
(
    sql_function character varying(1) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    op_quarter numeric(1,0) NOT NULL,
    count_op_time numeric(10,0),
    sum_op_time numeric(10,2),
    gload numeric(12,2),
    sload numeric(12,2),
    tload numeric(12,2),
    heat_input numeric(15,3),
    so2_mass numeric(12,3),
    so2_mass_lbs numeric(15,3),
    so2_rate numeric(16,4),
    so2_rate_sum numeric(15,3),
    so2_rate_count numeric(4,0),
    co2_mass numeric(12,3),
    co2_rate numeric(16,4),
    co2_rate_sum numeric(15,3),
    co2_rate_count numeric(4,0),
    nox_mass numeric(12,3),
    nox_mass_lbs numeric(15,3),
    nox_rate numeric(16,4),
    nox_rate_sum numeric(15,3),
    nox_rate_count numeric(4,0),
    num_months_reported double precision,
    rpt_period_id numeric(38,0),
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    skey numeric NOT NULL,
    logged_time timestamp without time zone,
    CONSTRAINT pk_quarter_unit_data_log PRIMARY KEY (skey)
);

CREATE INDEX IF NOT EXISTS idx_quarter_unit_data_log_sql_function
    ON camddmw.quarter_unit_data_log USING btree
    (sql_function ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_quarter_unit_data_log_unit_id
    ON camddmw.quarter_unit_data_log USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_quarter_unit_data_log_op_year
    ON camddmw.quarter_unit_data_log USING btree
    (op_year ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_quarter_unit_data_log_op_quarter
    ON camddmw.quarter_unit_data_log USING btree
    (op_quarter ASC NULLS LAST);
