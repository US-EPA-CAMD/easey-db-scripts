CREATE OR REPLACE VIEW camdecmpsmd.vw_uom_code_for_quallee AS
select  ccv.value1 as unit_of_standard_code
from  camdecmpsmd.CROSS_CHECK_CATALOG ccc
join camdecmpsmd.CROSS_CHECK_CATALOG_VALUE ccv using ( cross_chk_catalog_id )
where  ccc.cross_chk_catalog_name = 'Units of Measure to Category'
and  ccv.value2 = 'QUALLEE';