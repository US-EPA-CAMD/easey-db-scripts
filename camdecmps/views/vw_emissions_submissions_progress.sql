-- View: camdecmps.vw_emissions_submissions_progress

-- DROP VIEW camdecmps.vw_emissions_submissions_progress;

CREATE OR REPLACE VIEW camdecmps.vw_emissions_submissions_progress
 AS
 SELECT rp.begin_date,
    rp.end_date,
    expected.calendar_year,
    expected.quarter,
    COALESCE(100::numeric * (received.total::numeric / expected.total::numeric), 0::numeric) AS submitted_percentage,
    COALESCE(received.total, 0::bigint) AS submitted_count,
    expected.total - COALESCE(received.total, 0::bigint) AS remaining_count,
    expected.total AS total_expected_count,
    COALESCE(100::numeric * (gdm.used_count::numeric / expected.total::numeric), 0::numeric) AS gdm_used_percentage,
    COALESCE(gdm.used_count, 0::bigint) AS gdm_used_count,
    COALESCE(expected.total - gdm.used_count, 0::bigint) AS gdm_remaining_count
   FROM camdecmps.vw_emissions_submissions_received received
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmps.vw_emissions_submissions_expected expected ON expected.rpt_period_id = received.rpt_period_id
     LEFT JOIN camdecmps.vw_emissions_submissions_gdm gdm ON expected.rpt_period_id = gdm.rpt_period_id
  ORDER BY rp.begin_date;
