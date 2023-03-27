--Fuel Codes for Unit Defaults
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
	VALUES ('Fuel Codes to Category'
			,'Links Fuel Codes to the Categories for which they are appropriate'
			, 'FUEL_CODE'
			, 'FUEL_CD'
			, 'FuelCode'
			, null
			, 'CATEGORY_CODE'
			, 'CATEGORY_CD'
			, 'CategoryCode'
			, null
			, null
			, null
			, null
			, null);
	
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'BFG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'BUT', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'CDG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'COG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'DGG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'DSL', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'LFG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'LPG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'MIX', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'NNG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'OGS', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'OIL', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'OOL', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'PDG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'PNG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'PRG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'PRP', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'RFG', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Fuel Codes to Category'), 'SRG', 'UNITDEFAULT', null);

--Operating Condition Codes for Unit Defaults
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Operating Condition to Category'), 'A', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Operating Condition to Category'), 'B', 'UNITDEFAULT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Operating Condition to Category'), 'P', 'UNITDEFAULT', null);

/*
--DATA VALIDATION SCRIPTS
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Fuel Codes to Category' and value2='UNITDEFAULT'; --19 rows
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Operating Condition to Category' and value2='UNITDEFAULT'; --3 rows
select * from camdecmpsmd.vw_unit_default_master_data_relationships; --57 rows
*/