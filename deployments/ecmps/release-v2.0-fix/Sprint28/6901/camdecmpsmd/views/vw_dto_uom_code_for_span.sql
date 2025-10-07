CREATE OR REPLACE VIEW camdecmpsmd.vw_uom_code_for_span AS
select  distinct
        uom.unit_of_measure_code,
        spn.value2 as record_type
from  ( 
      select  ccv.value1 as component_type_code,
      	ccv.value2
      from  camdecmpsmd.CROSS_CHECK_CATALOG ccc
      join camdecmpsmd.CROSS_CHECK_CATALOG_VALUE ccv using ( cross_chk_catalog_id )
      where  ccc.cross_chk_catalog_name = 'Component Type to Category'
      and  ccv.value2 = 'SPAN'
      ) spn
      join 
      (
       select  ccv.value1 as component_type_code,
             ccv.value2 as unit_of_measure_code
      from  camdecmpsmd.CROSS_CHECK_CATALOG ccc
      join camdecmpsmd.CROSS_CHECK_CATALOG_VALUE ccv using ( cross_chk_catalog_id )
      where  ccc.cross_chk_catalog_name = 'Component Type Code to Units of Measure for Span'
      ) uom
      on uom.component_type_code = spn.component_type_code;