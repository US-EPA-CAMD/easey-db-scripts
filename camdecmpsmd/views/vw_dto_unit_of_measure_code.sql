


 
 CREATE OR REPLACE VIEW camdecmpsmd.vw_dto_unit_of_measure_code AS
WITH cross_check as (
    SELECT cccv.cross_chk_catalog_value_id,
    ccc.cross_chk_catalog_name,
    cccv.value1,
    cccv.value2
   FROM camdecmpsmd.cross_check_catalog_value cccv
     LEFT JOIN camdecmpsmd.cross_check_catalog ccc ON cccv.cross_chk_catalog_id = ccc.cross_chk_catalog_id
 )
SELECT uom.unit_of_measure_code,
        null as unit_of_standard_code,
       component.record_type
FROM (  SELECT param.value1 AS component_type_code,
     param.value2 as record_type
       FROM cross_check param
       WHERE param.cross_chk_catalog_name::text = 'Component Type to Category'::text AND param.value2 = 'SPAN'::text) component
LEFT JOIN ( SELECT DISTINCT param2.value1 AS component_type_code,
param2.value2 AS unit_of_measure_code
        FROM cross_check param2
        WHERE param2.cross_chk_catalog_name::text = 'Component Type Code to Units of Measure for Span'::text) uom ON component.component_type_code = uom.component_type_code
UNION
SELECT unit.value1 AS unit_of_measure_code,
        null as unit_of_standard_code,
        unit.value2 AS record_type
           FROM cross_check unit
          WHERE unit.cross_chk_catalog_name::text = 'Units of Measure to Category'::text AND unit.value2 = 'LOAD'::text
UNION 
SELECT unit.value1 AS unit_of_measure_code,
        null as unit_of_standard_code,
        unit.value2 AS record_type
           FROM cross_check unit
          WHERE unit.cross_chk_catalog_name::text = 'Units of Measure to Category'::text AND unit.value2 = 'SYSFUEL'::text
UNION
SELECT uom.unit_of_measure_code,
        null as unit_of_standard_code,
	  	param_code.record_type
         FROM
(SELECT param.value1 AS parameter_code,
		param.value2 as record_type
           FROM cross_check param
    WHERE param.cross_chk_catalog_name::text = 'Parameter to Category'::text AND param.value2 = 'DEFAULT'::text) param_code
     LEFT JOIN ( SELECT 
     param2.value1 AS parameter_code,
            param2.value2 AS unit_of_measure_code
           FROM cross_check param2
          WHERE param2.cross_chk_catalog_name::text = 'Parameter Code to Units of Measure Code for Defaults'::text) uom ON param_code.parameter_code = uom.parameter_code
UNION
SELECT  null as unit_of_measure_code,
        param.value1 AS unit_of_standard_code,
        param.value2 as record_type
           FROM cross_check param
          WHERE param.cross_chk_catalog_name::text = 'Units of Measure to Category'::text AND param.value2 = 'QUALLEE'::text