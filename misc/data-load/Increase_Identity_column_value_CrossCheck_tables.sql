-- RESET IDENTIFYING COLUMNS TO MOST MAX VALUE
select max(cross_chk_catalog_id) from camdecmpsmd.cross_check_catalog group by cross_chk_catalog_id

ALTER TABLE IF EXISTS camdecmpsmd.cross_check_catalog
    ALTER COLUMN cross_chk_catalog_id RESTART SET START 98;

select max(cross_chk_catalog_value_id) from camdecmpsmd.cross_check_catalog_value

ALTER TABLE IF EXISTS camdecmpsmd.cross_check_catalog_value
    ALTER COLUMN cross_chk_catalog_value_id RESTART SET START 1647

	

