CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_hiunitstack(
    em_hi_unitstack_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    mon_plan_id VARCHAR(45) NOT NULL,
    mon_loc_id VARCHAR(45) NOT NULL,
    rpt_period_id INTEGER NOT NULL,
    date_hour varchar(25) NOT NULL,
    op_time NUMERIC(3,2),
    unit_load NUMERIC(6,0),
    load_uom VARCHAR(7),
    load_range INTEGER,
    common_stack_load_range INTEGER,
    hi_formula_cd VARCHAR(7),
    rpt_hi_rate NUMERIC(14,4),
    calc_hi_rate NUMERIC(14,4),
    error_codes VARCHAR(1000)
)