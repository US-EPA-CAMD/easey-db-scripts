CREATE OR REPLACE VIEW camdecmpsmd.vw_dto_parameter_code AS
WITH cross_check as (
        SELECT cccv.cross_chk_catalog_value_id,
    ccc.cross_chk_catalog_name,
    cccv.value1,
    cccv.value2
   FROM camdecmpsmd.cross_check_catalog_value cccv
     LEFT JOIN camdecmpsmd.cross_check_catalog ccc ON cccv.cross_chk_catalog_id = ccc.cross_chk_catalog_id
 )
SELECT param.value1 AS parameter_code,
    param.value2 AS record_type
FROM cross_check param
WHERE param.cross_chk_catalog_name::text = 'Parameter to Category'::text AND param.value2 = 'DEFAULT'::text
UNION 
SELECT param.value1 AS parameter_code,
    param.value2 AS record_type
FROM cross_check param
WHERE param.cross_chk_catalog_name::text = 'Parameter to Category'::text AND param.value2 = 'QUALLEE'::text
UNION
SELECT param.value1 AS parameter_code,
    param.value2 AS record_type
FROM cross_check param
WHERE param.cross_chk_catalog_name::text = 'Parameter to Category'::text AND param.value2 = 'METHOD'::text;