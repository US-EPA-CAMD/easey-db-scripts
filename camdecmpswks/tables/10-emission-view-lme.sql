CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_lme(
    em_lme_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    mon_plan_id VARCHAR(45) NOT NULL,
    mon_loc_id VARCHAR(45) NOT NULL,
    rpt_period_id INTEGER NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time NUMERIC(3,2),
    unit_load NUMERIC(6,0),
    load_uom VARCHAR(7),
    hour_id VARCHAR(45) NOT NULL,
    hi_modc VARCHAR(7),
    rpt_heat_input NUMERIC(14,4),
    calc_heat_input NUMERIC(14,4),
    so2m_fuel_type VARCHAR(7),
    so2_emiss_rate NUMERIC(15,4),
    rpt_so2_mass NUMERIC(14,4),
    calc_so2_mass NUMERIC(14,4),
    noxm_fuel_type VARCHAR(7),
    operating_condition_cd VARCHAR(7),
    nox_emiss_rate NUMERIC(15,4),
    rpt_nox_mass NUMERIC(14,4),
    calc_nox_mass NUMERIC(14,4),
    co2m_fuel_type VARCHAR(7),
    co2_emiss_rate NUMERIC(15,4),
    rpt_co2_mass NUMERIC(14,4),
    calc_co2_mass NUMERIC(14,4),
    error_codes VARCHAR(1000)
)