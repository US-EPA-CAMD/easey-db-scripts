-- Table: camddmw.hour_unit_mats_data_log

-- DROP TABLE camddmw.hour_unit_mats_data_log;

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_mats_data_log
(
    sql_function character varying(1) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    op_date date NOT NULL,
    op_hour numeric(2,0) NOT NULL,
    op_time numeric(3,2),
    gload numeric(8,2),
    sload numeric(8,2),
    tload numeric(8,2),
    heat_input numeric(15,3),
    heat_input_measure_flg character varying(60) COLLATE pg_catalog."default",
    hg_rate_eo numeric(22,10),
    hg_rate_hi numeric(22,10),
    hg_mass numeric(22,10),
    hg_measure_flg character varying(60) COLLATE pg_catalog."default",
    hcl_rate_eo numeric(22,10),
    hcl_rate_hi numeric(22,10),
    hcl_mass numeric(22,10),
    hcl_measure_flg character varying(60) COLLATE pg_catalog."default",
    hf_rate_eo numeric(22,10),
    hf_rate_hi numeric(22,10),
    hf_mass numeric(22,10),
    hf_measure_flg character varying(60) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    data_source character varying(35) COLLATE pg_catalog."default" NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp(0) without time zone NOT NULL,
    skey numeric NOT NULL,
    logged_time timestamp without time zone,
    CONSTRAINT pk_hour_unit_mats_data_log PRIMARY KEY (skey)
);

DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_op_date;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_op_hour;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_op_time;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_op_year;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_sql_function;
DROP INDEX IF EXISTS camddmw.idx_hour_unit_mats_data_log_unit_id;

CREATE INDEX IF NOT EXISTS idx_hour_unit_mats_data_log_sql_function
    ON camddmw.hour_unit_mats_data_log USING btree
    (sql_function ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hour_unit_mats_data_log_unit_id
    ON camddmw.hour_unit_mats_data_log USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hour_unit_mats_data_log_op_date
    ON camddmw.hour_unit_mats_data_log USING btree
    (op_date ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hour_unit_mats_data_log_op_hour
    ON camddmw.hour_unit_mats_data_log USING btree
    (op_hour ASC NULLS LAST);
