
DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE cross_chk_catalog_id = 21
  AND value1 = 'CPM';

--Remove rows with Method Parameter Code equal to "PMPMA" or "PMPMC"
DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE cross_chk_catalog_id = 8
  AND value1 in ('PMPMA,PMPMC');

--Remove row for Parameter Code: "PMPMA", Category Code: "METHOD"
--Remove row for Parameter Code "PMPMC", Category Code: "METHOD"
DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE cross_chk_catalog_id = 11
  AND value1 in ('PMPMA,PMPMC')
  AND value2 = 'METHOD';

--Remove row with System Type Code equal to "CPMS"
DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE cross_chk_catalog_id = 15
  AND value1 = 'CPMS';

--Remove row with System Type Code equal to "CPMS"
DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE cross_chk_catalog_id = 14
  AND value1 = 'CPMS';

--Remove row for Component Type Code "CPM"
DELETE FROM camdecmpsmd.component_type_code
WHERE component_type_cd = 'CPM';

--Remove row for Method Code "CPMS"
DELETE FROM camdecmpsmd.method_code
WHERE method_cd = 'CPMS';

--Remove row for Qualification Type Code "CPMS"
DELETE FROM camdecmps.monitor_qualification where qual_type_cd  = 'CPMS';
DELETE FROM camdecmpsmd.qual_type_code
WHERE qual_type_cd = 'CPMS';

--Remove row for System Type Code "CPMS"
DELETE FROM camdecmpsmd.system_type_code
WHERE sys_type_cd = 'CPMS';