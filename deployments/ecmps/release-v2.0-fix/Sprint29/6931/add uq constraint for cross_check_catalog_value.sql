alter table camdecmpsmd.cross_check_catalog_value
 add CONSTRAINT uq_cross_check_catalog_value UNIQUE (cross_chk_catalog_id,value1,value2,value3);
