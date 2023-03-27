--Parameter Code for Qualification LEE
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Parameter to Category'), 'HG', 'QUALLEE', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Parameter to Category'), 'HCL', 'QUALLEE', null);

--Units Of Measure for Qualification LEE
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Units of Measure to Category'), 'LBTBTU', 'QUALLEE', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Units of Measure to Category'), 'LBMMBTU', 'QUALLEE', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Units of Measure to Category'), 'LBMWH', 'QUALLEE', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Units of Measure to Category'), 'LBGWH', 'QUALLEE', null);

/*
--DATA VALIDATION SCRIPT(S)
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Parameter to Category' and value2='QUALLEE'; --2 rows
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Units of Measure to Category' and value2='QUALLEE'; --4 rows
select * from camdecmpsmd.qual_lee_test_type_code; --2 rows
select * from camdecmpsmd.vw_quallee_master_data_relationships; --16 rows
*/