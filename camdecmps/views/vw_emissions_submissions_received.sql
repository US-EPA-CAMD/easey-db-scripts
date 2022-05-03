-- View: camdecmps.vw_emissions_submissions_received

DROP VIEW IF EXISTS camddmw.vw_emissions_submissions_received;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_received;

CREATE OR REPLACE VIEW camdecmps.vw_emissions_submissions_received
 AS
 SELECT em_submission_access.rpt_period_id,
    count(em_submission_access.em_sub_access_id) AS total
   FROM camdecmpsaux.em_submission_access
  WHERE em_submission_access.em_status_cd::text = 'RECVD'::text AND em_submission_access.em_sub_type_cd::text = 'INITIAL'::text AND em_submission_access.sub_availability_cd::text <> 'DELETE'::text
  GROUP BY em_submission_access.rpt_period_id
  ORDER BY em_submission_access.rpt_period_id;
