-- View: camdecmps.vw_emissions_submissions_expected

DROP VIEW IF EXISTS camddmw.vw_emissions_submissions_expected;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_expected;

CREATE OR REPLACE VIEW camdecmps.vw_emissions_submissions_expected
 AS
 SELECT esa.rpt_period_id,
    count(esa.em_sub_access_id) AS total,
    rp.calendar_year,
    rp.quarter
   FROM camdecmpsaux.em_submission_access esa,
    camdecmpsmd.reporting_period rp
  WHERE esa.rpt_period_id = rp.rpt_period_id AND esa.em_sub_type_cd::text = 'INITIAL'::text AND COALESCE(esa.sub_availability_cd, 'NULL'::character varying)::text <> 'DELETE'::text
  GROUP BY esa.rpt_period_id, rp.calendar_year, rp.quarter
  ORDER BY esa.rpt_period_id, rp.calendar_year, rp.quarter;
