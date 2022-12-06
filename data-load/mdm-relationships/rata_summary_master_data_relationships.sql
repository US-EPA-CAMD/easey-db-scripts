--System Type to Reference Method
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
	VALUES ('System Type to Reference Method Codes'
			,'Links System Types to Reference Methods for which they are appropriate'
			, 'SYSTEM_TYPE_CODE'
			, 'SYSTEM_TYPE_CD'
			, 'SystemTypeCode'
			, null
			, 'REFERENCE_METHOD_CODE'
			, 'REFERENCE_METHOD_CD'
			, 'ReferenceMethodCode'
			, null
			, null
			, null
			, null
			, null);

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'O2', '3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'O2', '3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'O2', '3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'CO2', '3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'CO2', '3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'CO2', '3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'H2O', '4', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'H2OM', '4', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HG', 'OH', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HG', '29', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HG', '30A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HG', '30B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'ST', 'OH', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'ST', '29', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'ST', '30A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'ST', '30B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HF', '26', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HF', '26A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HF', '320', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HF', 'D6348', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HCL', '26', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HCL', '26A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HCL', '320', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'HCL', 'D6348', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '20,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '20,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '20,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7A,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7A,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7A,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7C,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7C,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7C,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7D,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7D,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7E,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7E,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOX', '7E,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXC', '20', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXC', '7', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXC', '7A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXC', '7C', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXC', '7D', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXC', '7E', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '20', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '20,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '20,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '20,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7A,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7A,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7A,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7C', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7C,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7C,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7C,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7D', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7D,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7D,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7E', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7E,3', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7E,3A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'NOXP', '7E,3B', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'SO2', '6', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'SO2', '6A', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'SO2', '6C', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', '2', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', 'M2H', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', 'D2H', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', '2F', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', '2G', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', '2FH', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', '2GH', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', '2J', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', '2FJ', null),
  VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Reference Method Codes'), 'FLOW', '2GJ', null);

--DATA VALIDATION SCRIPTS
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='System Type to Reference Method Codes';
select * from camdecmpsmd.vw_rata_summary_master_data_relationships;
