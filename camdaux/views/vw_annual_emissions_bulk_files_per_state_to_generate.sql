-- View: camdaux.vw_annual_emissions_bulk_files_per_state_to_generate

-- DROP VIEW camdaux.vw_annual_emissions_bulk_files_per_state_to_generate;

CREATE OR REPLACE VIEW camdaux.vw_annual_emissions_bulk_files_per_state_to_generate
 AS
 SELECT rp.calendar_year AS year,
    p.state AS state_cd
   FROM camdecmps.dm_emissions dme
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     JOIN camdecmps.monitor_plan mp USING (mon_plan_id)
     JOIN camd.plant p USING (fac_id)
     LEFT JOIN camdecmps.dm_emissions_user dmeu ON dme.dm_emissions_id::text = dmeu.dm_emissions_id::text AND dmeu.dm_emissions_user_cd::text = 'S3BDF'::text
  WHERE dmeu.dm_emissions_id IS NULL
  GROUP BY rp.calendar_year, p.state
  ORDER BY rp.calendar_year, p.state;
