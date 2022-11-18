CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_co2dailyfuel(
    em_co2_daily_fuel_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    mon_plan_id VARCHAR(45) NOT NULL,
    mon_loc_id VARCHAR(45) NOT NULL,
    rpt_period_id INTEGER NOT NULL,
    date DATE NOT NULL,
    rpt_total_daily_co2_mass NUMERIC(10,1),
    rpt_unadjusted_co2_mass NUMERIC(10,1),
    rpt_adjusted_daily_co2_mass NUMERIC(10,1),
    rpt_sorbent_rltd_co2_mass NUMERIC(10,1),
    error_codes VARCHAR(1000),
    fuel_cd VARCHAR(7),
    daily_fuel_feed NUMERIC(13,1),
    carbon_content_used NUMERIC(5,1),
    fuel_carbon_burned NUMERIC(13,1),
    calc_fuel_carbon_burned NUMERIC(13,1),
    total_carbon_burned NUMERIC(13,1),
    calc_total_daily_emission NUMERIC(10,1)
)