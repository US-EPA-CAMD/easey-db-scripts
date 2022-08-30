CREATE OR REPLACE VIEW camdecmpswks.vw_mp_daily_emission (mon_plan_id, daily_emission_id, mon_loc_id, rpt_period_id, oris_code, location_name, calendar_year, quarter, begin_date, parameter_cd, total_daily_emission, total_carbon_burned, adjusted_daily_emission, unadjusted_daily_emission, sorbent_mass_emission) AS
SELECT
    mon_plan_id, daily_emission_id, vwMl.mon_loc_id, rp.rpt_period_id, oris_code, location_name, calendar_year, quarter, de.begin_date, parameter_cd, total_daily_emission, total_carbon_burned, adjusted_daily_emission, unadjusted_daily_emission, sorbent_mass_emission
    FROM camdecmpswks.daily_emission de
    INNER JOIN camdecmpswks.vw_mp_monitor_location vwMl
        ON vwMl.mon_loc_id = de.mon_loc_id
    INNER JOIN camdecmpsmd.reporting_period rp
        ON rp.rpt_period_id = de.rpt_period_id;