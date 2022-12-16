--Susbtitute Data Code for Method
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
	VALUES ('Method Parameter to Substitute Data Code for Methods'
			,'Cross check table linking method parameter codes to substitute data codes, for methods'
			, 'PARAMETER_CODE'
			, 'PARAMETER_CD'
			, 'ParamaterCode'
			, null
			, 'SUBSTITUTE_DATA_CODE'
			, 'SUBSTITUTE_DATA_CD'
			, 'SubstituteDataCode'
			, null
			, null
			, null
			, null
			, null);
	
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'CO2', 'FSP75', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'CO2', 'FSP75C', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'CO2', 'SPTS', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'H2O', 'FSP75', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'H2O', 'FSP75C', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'H2O', 'REV75', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'H2O', 'SPTS', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'HI', 'FSP75', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'HI', 'FSP75C', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'HI', 'NLB', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'HI', 'NLBOP', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'HI', 'SPTS', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'HIT', 'MHHI', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOX', 'FSP75', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOX', 'FSP75C', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOX', 'NLB', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOX', 'NLBOP', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOX', 'OZN75', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOX', 'SPTS', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOXR', 'FSP75', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOXR', 'FSP75C', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOXR', 'NLB', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOXR', 'NLBOP', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOXR', 'OZN75', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'NOXR', 'SPTS', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'SO2', 'FSP75', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'SO2', 'FSP75C', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'), 'SO2', 'SPTS', null);

--Bypass Approach Code
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
	VALUES ('Method Parameter to Method Code to Bypass Approach for Methods'
			,'Cross check table linking method parameter codes to method and bypass approach codes, for methods'
			, 'PARAMETER_CODE'
			, 'PARAMETER_CD'
			, 'ParamaterCode'
			, null
			, 'METHOD_CODE'
			, 'METHOD_CD'
			, 'MethodCode'
			, null
			, 'BYPASS_APPROACH_CODE'
			, 'BYPASS_APPROACH_CD'
			, 'BypassAproachCode'
			, null);

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'SO2', 'CEM', 'BYMAX');
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'SO2', 'CEM', 'BYMAXFS');
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'SO2', 'CEMF23', 'BYMAX');
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'SO2', 'CEMF23', 'BYMAXFS');
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'NOX', 'CEM', 'BYMAX');
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'NOX', 'CEM', 'BYMAXFS');
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'NOX', 'NOXR', 'BYMAX');
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'NOX', 'NOXR', 'BYMAXFS');
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'NOXR', 'CEM', 'BYMAX');
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'), 'NOXR', 'CEM', 'BYMAXFS');

--DATA VALIDATION SCRIPTS
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Parameter to Category' and value2='METHOD'; --19 rows
select distinct value1, value2 from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Method Parameter to Method to System Type' order by value1; --56 rows
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Method Parameter to Substitute Data Code for Methods'; --28 rows
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Method Parameter to Method Code to Bypass Approach for Methods'; --10 rows
select * from camdecmpsmd.vw_methods_master_data_relationships; --172 rows
