CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_moisture(
    em_moisture_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    mon_plan_id VARCHAR(45) NOT NULL,
    mon_loc_id VARCHAR(45) NOT NULL,
    rpt_period_id INTEGER NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time NUMERIC(3,2),
    h2o_modc VARCHAR(7),
    h2o_pma NUMERIC(4,1),
    pct_o2_wet NUMERIC(13,3),
    o2_wet_modc VARCHAR(7),
    pct_o2_dry NUMERIC(13,3),
    o2_dry_modc VARCHAR(7),
    h2o_formula_cd VARCHAR(7),
    rpt_pct_h2o NUMERIC(14,4),
    calc_pct_h2o NUMERIC(14,4),
    error_codes VARCHAR(1000)
);