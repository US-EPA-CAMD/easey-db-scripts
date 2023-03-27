-- View: camdecmpsmd.vw_emissions_api_check_catalog_results

DROP VIEW IF EXISTS camdecmpsmd.vw_emissions_api_check_catalog_results;

CREATE OR REPLACE VIEW camdecmpsmd.vw_emissions_api_check_catalog_results
 AS
 SELECT vw_check_catalog_result.check_type_cd AS "checkTypeCode",
    vw_check_catalog_result.check_number AS "checkNumber",
    vw_check_catalog_result.check_result AS "resultCode",
    vw_check_catalog_result.response_catalog_description AS "resultMessage"
   FROM camdecmpsmd.vw_check_catalog_result
     JOIN camdecmpsmd.check_catalog_process USING (check_catalog_id)
  WHERE check_catalog_process.process_cd::text = ANY (ARRAY['EMIMPRT'::character varying::text, 'LMEIMPT'::character varying::text, 'LMESCRN'::character varying::text])
  ORDER BY vw_check_catalog_result.check_type_cd, vw_check_catalog_result.check_number, vw_check_catalog_result.check_result;
