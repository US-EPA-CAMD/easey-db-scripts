update  camdecmpsmd.CROSS_CHECK_CATALOG_VALUE
   set  value1 = 'HIT'
 where  cross_chk_catalog_id = 16
   and  value1 = 'HI'
   and  value2 is null
   and  value3 = 'SS-3A';

delete
  from  camdecmpsmd.CROSS_CHECK_CATALOG_VALUE dat
 where  dat.cross_chk_catalog_id = 16
   and  dat.value1 = 'HFRE'
   and  dat.value2 = 'O2B'
   and  dat.value3 = '19-5';

update  camdecmpsmd.CROSS_CHECK_CATALOG_VALUE
   set  value3 = null
 where  cross_chk_catalog_id = 27
   and  value1 = 'CO2R'
   and  value2 = 'LM'
   and  value3 = '';

INSERT INTO camdecmpsmd.cross_check_catalog_value (cross_chk_catalog_value_id, cross_chk_catalog_id, value1, value2, value3) OVERRIDING SYSTEM VALUE VALUES (9337, 28, 'NOCX', 'MAXD', null);

delete 
  from  camdecmpsmd.CROSS_CHECK_CATALOG_VALUE
 where  cross_chk_catalog_id in ( 192, 194, 195 );


delete 
  from  camdecmpsmd.CROSS_CHECK_CATALOG
 where  cross_chk_catalog_id in ( 192, 194, 195 );
