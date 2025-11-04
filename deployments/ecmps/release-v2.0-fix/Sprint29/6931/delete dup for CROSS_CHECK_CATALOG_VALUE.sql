 --delete current existing duplicates records 
delete
  from  camdecmpsmd.CROSS_CHECK_CATALOG_VALUE
 where  cross_chk_catalog_value_id in ( 1401, 1403, 1407, 1410, 1418, 1513, 1521, 9325 );

