CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_noxratecems(
    em_nox_rate_cems_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    mon_plan_id VARCHAR(45) NOT NULL,
    mon_loc_id VARCHAR(45) NOT NULL,
    rpt_period_id INTEGER NOT NULL,
    date_hour varchar(25) NOT NULL,
    op_time NUMERIC(3,2),
    unit_load NUMERIC(6,0),
    load_uom VARCHAR(7),
    nox_rate_modc VARCHAR(7),
    nox_rate_pma NUMERIC(4,1),
    unadj_nox NUMERIC(13,3),
    nox_modc VARCHAR(7),
    diluent_param VARCHAR(3),
    pct_diluent_used NUMERIC(5,1),
    diluent_modc VARCHAR(7),
    pct_h2o_used NUMERIC(5,1),
    source_h2o_value VARCHAR(7),
    f_factor NUMERIC(8,1),
    nox_rate_formula_cd VARCHAR(7),
    rpt_unadj_nox_rate NUMERIC(13,3),
    calc_unadj_nox_rate NUMERIC(13,3),
    calc_nox_baf NUMERIC(5,3),
    rpt_adj_nox_rate NUMERIC(14,4),
    calc_adj_nox_rate NUMERIC(14,4),
    calc_hi_rate NUMERIC(14,4),
    nox_mass_formula_cd VARCHAR(7),
    rpt_nox_mass NUMERIC(14,4),
    calc_nox_mass NUMERIC(14,4),
    error_codes VARCHAR(1000),
    rpt_diluent NUMERIC(13,3)
)