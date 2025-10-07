CREATE OR REPLACE VIEW camdecmpsmd.vw_uom_code_for_default AS
select  distinct
        uom.unit_of_measure_code,
        def.value2 as record_type
from  ( 
      select  ccv.value1 as parameter_code,
              ccv.value2 
      from  camdecmpsmd.CROSS_CHECK_CATALOG ccc
      join camdecmpsmd.CROSS_CHECK_CATALOG_VALUE ccv using ( cross_chk_catalog_id )
      where  ccc.cross_chk_catalog_name = 'Parameter to Category'
      and  ccv.value2 = 'DEFAULT'
      ) def
      join 
      (
      select  ccv.value1 as parameter_code,
              ccv.value2 as unit_of_measure_code
      from  camdecmpsmd.CROSS_CHECK_CATALOG ccc
      join camdecmpsmd.CROSS_CHECK_CATALOG_VALUE ccv using ( cross_chk_catalog_id )
      where  ccc.cross_chk_catalog_name = 'Parameter Code to Units of Measure Code for Defaults'
       ) uom
      on uom.parameter_code = def.parameter_code;