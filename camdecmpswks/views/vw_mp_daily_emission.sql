-- View: camdecmpswks.vw_mp_daily_emission

DROP VIEW IF EXISTS camdecmpswks.vw_mp_daily_emission;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_daily_emission
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
    de.total_carbon_burned,
    de.adjusted_daily_emission,
    de.unadjusted_daily_emission,
    de.sorbent_mass_emission
   FROM camdecmpswks.daily_emission de
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON vwml.mon_loc_id::text = de.mon_loc_id::text
     JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = de.rpt_period_id;
