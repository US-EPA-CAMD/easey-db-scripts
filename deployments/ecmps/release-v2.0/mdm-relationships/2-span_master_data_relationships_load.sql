--Component type Code for SPAN
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
	VALUES ('Component Type to Category'
			,'Links Component Type Codes to the Categories for which they are appropriate'
			, 'COMPONENT_TYPE_CODE'
			, 'COMPONENT_TYPE_CD'
			, 'ComponentTypeCode'
			, null
			, 'CATEGORY_CODE'
			, 'CATEGORY_CD'
			, 'CategoryCode'
			, null
			, null
			, null
			, null
			, null);
	
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'CO2', 'SPAN', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'FLOW', 'SPAN', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'HCL', 'SPAN', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'HG', 'SPAN', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'NOX', 'SPAN', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'O2', 'SPAN', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'SO2', 'SPAN', null);

--Component type Code to Units of Measure
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
	VALUES ('Component Type Code to Units of Measure for Span'
			,'Links Component Type Codes to Units of measure codes for which they are appropriate, for Span'
			, 'COMPONENT_TYPE_CODE'
			, 'COMPONENT_TYPE_CD'
			, 'ComponentTypeCode'
			, null
			, 'UNITS_OF_MEASURE_CODE'
			, 'UNITS_OF_MEASURE_CD'
			, 'UnitsOfMeasureCode'
			, null
			, null
			, null
			, null
			, null);
	
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'CO2', 'PCT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'FLOW', 'ACFH', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'FLOW', 'ACFM', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'FLOW', 'AFPM', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'FLOW', 'AFSEC', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'HCL', 'PPM', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'HG', 'UGSCM', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'NOX', 'PPM', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'O2', 'PCT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'), 'SO2', 'PPM', null);

--DATA VALIDATION SCRIPTS
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Component Type to Category' and value2='SPAN'; --7 rows
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Component Type and Span Scale to Span Method'; --31 rows
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Component Type Code to Units of Measure for Span'; --10 rows
select * from camdecmpsmd.vw_span_master_data_relationships; --40 rows
