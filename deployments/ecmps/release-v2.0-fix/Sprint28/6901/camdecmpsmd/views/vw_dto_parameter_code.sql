CREATE OR REPLACE VIEW camdecmpsmd.vw_dto_parameter_code AS
select  ccv.value1 as parameter_code,
        ccv.value2 as record_type
from  camdecmpsmd.CROSS_CHECK_CATALOG ccc
join camdecmpsmd.CROSS_CHECK_CATALOG_VALUE ccv using ( cross_chk_catalog_id )
where  ccc.cross_chk_catalog_name = 'Parameter to Category'
and  ccv.value2 in ( 'DEFAULT', 'METHOD', 'QUALLEE' );