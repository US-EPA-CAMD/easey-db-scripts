CREATE OR REPLACE VIEW camdecmpsmd.vw_emissions_api_check_catalog_results AS
SELECT check_type_cd AS "checkTypeCode",
	check_number AS "checkNumber",
	check_result AS "resultCode",
	response_catalog_description AS "resultMessage"
FROM camdecmpsmd.vw_check_catalog_result
JOIN camdecmpsmd.check_catalog_process USING(check_catalog_id)
WHERE process_cd IN ('EMIMPRT', 'LMEIMPT', 'LMESCRN')
ORDER BY check_type_cd, check_number, check_result;