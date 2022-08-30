-- View: camdecmpsmd.vw_test_summary_master_data_relationships

-- DROP VIEW camdecmpsmd.vw_test_summary_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_test_summary_master_data_relationships
 AS
 SELECT ttc.test_type_code,
	reasons.test_reason_code,
    results.test_result_code,
    gas.gas_level_code
   FROM ( SELECT value1 AS test_type_code
          FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE cross_chk_catalog_name::text = 'Test Type to Category'::text
          AND value2 = 'TESTSUMMARY') AS ttc
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS test_type_code,
            vw_cross_check_catalog_value.value2 AS test_reason_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Test Type to Test Reason Codes'::text) AS reasons ON ttc.test_type_code = reasons.test_type_code
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS test_type_code,
            vw_cross_check_catalog_value.value2 AS test_result_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Test Type to Test Result Codes'::text) AS results ON ttc.test_type_code = results.test_type_code
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS test_type_code,
            vw_cross_check_catalog_value.value2 AS gas_level_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Test Type to Gas Level Codes'::text) AS gas ON ttc.test_type_code = gas.test_type_code;
