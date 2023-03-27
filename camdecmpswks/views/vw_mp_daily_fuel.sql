-- View: camdecmpswks.vw_mp_daily_fuel

DROP VIEW IF EXISTS camdecmpswks.vw_mp_daily_fuel;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_daily_fuel
 AS
 SELECT vwml.mon_plan_id,
    de.daily_emission_id,
    vwml.mon_loc_id,
    rp.rpt_period_id,
    vwml.oris_code,
    vwml.location_name,
    rp.calendar_year,
    rp.quarter,
    de.begin_date,
    de.parameter_cd,
    de.total_daily_emission,
    de.adjusted_daily_emission,
    de.unadjusted_daily_emission,
    de.sorbent_mass_emission,
    df.daily_fuel_id,
    df.fuel_cd,
    df.daily_fuel_feed,
    df.carbon_content_used,
    df.fuel_carbon_burned
   FROM camdecmpswks.daily_fuel df
     JOIN camdecmpswks.daily_emission de ON df.daily_emission_id::text = de.daily_emission_id::text
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON vwml.mon_loc_id::text = de.mon_loc_id::text
     JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = de.rpt_period_id;
