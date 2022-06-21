--Test Type to Test Result Codes
INSERT INTO camdecmpsmd.cross_check_catalog(cross_chk_catalog_name
											, cross_chk_catalog_description
											, table_name1
											, column_name1
											, description1
											, field_type_cd1
											, table_name2
											, column_name2
											, description2
											, field_type_cd2
											, table_name3
											, column_name3
											, description3
											, field_type_cd3)
	VALUES ('Test Type to Test Result Codes'
			,'Links Test Result Codes to the Test Types for which they are appropriate'
			, 'TEST_TYPE_CODE'
			, 'TEST_TYPE_CD'
			, null
			, null
			, 'TEST_RESULT_CODE'
			, 'TEST_RESULT_CD'
			, null
			, null
			, null
			, null
			, null
			, null);

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Test Type to Test Result Codes'), 'LINE', 'ABORTED', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Test Type to Test Result Codes'), 'LINE', 'FAILED', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Test Type to Test Result Codes'), 'LINE', 'PASSED', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Test Type to Test Result Codes'), 'LINE', 'PASSAPS', null);


--DATA VALIDATION SCRIPTS
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Test Type to Test Result Codes'
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Test Type to Test Result Codes' and value1='LINE'
