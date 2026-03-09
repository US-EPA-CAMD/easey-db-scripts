update  camdecmpsmd.CROSS_CHECK_CATALOG_VALUE
   set  value1 = 'HI'
 where  cross_chk_catalog_id = 16
   and  value1 = 'HIT'
   and  value2 is null
   and  value3 = 'SS-3A';

commit;