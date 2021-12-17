-- View: camddmw.vw_emissions_submissions_gdm

-- DROP VIEW camddmw.vw_emissions_submissions_gdm;

CREATE OR REPLACE VIEW camddmw.vw_emissions_submissions_gdm
 AS
 SELECT dme.rpt_period_id,
    count(dmu.dm_emissions_user_id) AS used_count
   FROM camdecmps.dm_emissions dme,
    camdecmps.dm_emissions_user dmu
  WHERE dme.dm_emissions_id::text = dmu.dm_emissions_id::text AND dmu.dm_emissions_user_cd::text = 'GDM'::text AND dmu.complete_date IS NOT NULL
  GROUP BY dme.rpt_period_id;
