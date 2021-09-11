-- View: camdecmpsmd.vw_cross_check_catalog

-- DROP VIEW camdecmpsmd.vw_cross_check_catalog;

CREATE OR REPLACE VIEW camdecmpsmd.vw_cross_check_catalog
 AS
 SELECT cross_check_catalog.cross_chk_catalog_id,
    cross_check_catalog.cross_chk_catalog_name,
    cross_check_catalog.cross_chk_catalog_description,
    cross_check_catalog.table_name1,
    cross_check_catalog.column_name1,
    cross_check_catalog.description1,
    cross_check_catalog.field_type_cd1,
    cross_check_catalog.table_name2,
    cross_check_catalog.column_name2,
    cross_check_catalog.description2,
    cross_check_catalog.field_type_cd2,
    cross_check_catalog.table_name3,
    cross_check_catalog.column_name3,
    cross_check_catalog.description3,
    cross_check_catalog.field_type_cd3
   FROM camdecmpsmd.cross_check_catalog;
