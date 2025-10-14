-- to check the duplicates
select cross_chk_catalog_value_id
from (select min(cross_chk_catalog_value_id) cross_chk_catalog_value_id,
cross_chk_catalog_id, value1, value2, value3
from camdecmpsmd.CROSS_CHECK_CATALOG_VALUE 
 group  by  cross_chk_catalog_id,value1, value2,value3
having  count( * ) > 1 
 order by cross_chk_catalog_id, value1, value2, value3) dal;
 
 --delete current existing duplicates records 
 delete from camdecmpsmd.CROSS_CHECK_CATALOG_VALUE
	where cross_chk_catalog_value_id in (112, 534,537,1520,1417, 440, 156, 9320);

