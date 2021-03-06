-- View: camdaux.vw_annual_emissions_bulk_files_per_quarter_to_generate

-- DROP VIEW camdaux.vw_annual_emissions_bulk_files_per_quarter_to_generate;

CREATE OR REPLACE VIEW camdaux.vw_annual_emissions_bulk_files_per_quarter_to_generate
 AS
 SELECT rp.calendar_year AS year,
    rp.quarter,
    rp.begin_date AS qtr_begin_date,
    rp.end_date AS qtr_end_date
   FROM camdecmps.dm_emissions dme
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmps.dm_emissions_user dmeu ON dme.dm_emissions_id::text = dmeu.dm_emissions_id::text AND dmeu.dm_emissions_user_cd::text = 'S3BDF'::text
  WHERE dmeu.dm_emissions_id IS NULL AND now() >= (rp.end_date + '31 days'::interval day)
  GROUP BY rp.calendar_year, rp.quarter, rp.begin_date, rp.end_date
  ORDER BY rp.calendar_year, rp.quarter;
