--Units of Measure for Load
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
	VALUES ('Units of Measure to Category'
			,'Links Units of Measure Codes to the Categories for which they are appropriate'
			, 'PARAMETER_CODE'
			, 'PARAMETER_CD'
			, 'ParameterCode'
			, null
			, 'UOM_CATEGORY_CODE'
			, 'UOM_CATEGORY_CD'
			, 'CategoryCode'
			, null
			, null
			, null
			, null
			, null);

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Units of Measure to Category'), 'MW', 'LOAD', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Units of Measure to Category'), 'KLBHR', 'LOAD', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Units of Measure to Category'), 'MMBTUHR', 'LOAD', null);

--Operating Level for Load
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
	VALUES ('Operating Level to Category'
			,'Links Operaing Level Codes to the Categories for which they are appropriate'
			, 'PARAMETER_CODE'
			, 'PARAMETER_CD'
			, 'ParameterCode'
			, null
			, 'OPERATING_LEVEL_CATEGORY_CODE'
			, 'OPERATING_LEVEL_CATEGORY_CD'
			, 'CategoryCode'
			, null
			, null
			, null
			, null
			, null);

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Operating Level to Category'), 'L', 'LOAD', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Operating Level to Category'), 'M', 'LOAD', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Operating Level to Category'), 'H', 'LOAD', null);


--DATA VALIDATION SCRIPTS
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Units of Measure to Category' and value2='LOAD'; --3 rows
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Operating Level to Category' and value2='LOAD'; --3 rows
select * from camdecmpsmd.vw_load_master_data_relationships; --9 rows
