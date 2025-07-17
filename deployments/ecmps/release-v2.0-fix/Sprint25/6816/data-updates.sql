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