-- View: camdecmpswks.vw_cross_check_parameter_cd_method_cd_sub_data_cd

-- DROP VIEW camdecmpswks.vw_cross_check_parameter_cd_method_cd_sub_data_cd;

CREATE OR REPLACE VIEW camdecmpswks.vw_cross_check_parameter_cd_method_cd_sub_data_cd
 AS
 SELECT p.value1 AS parameter_cd,
    d2.method_cd,
    d2.sub_data_cd
   FROM camdecmpswks.vw_cross_check_catalog_value p
     LEFT JOIN ( SELECT ptm.value1 AS parameter_cd,
            ptm.value2 AS method_cd,
            d1.sub_data_cd
           FROM camdecmpswks.vw_cross_check_catalog_value ptm
             LEFT JOIN ( SELECT cccv.value1 AS method_cd,
                    cccv.value2 AS sub_data_cd
                   FROM camdecmpswks.vw_cross_check_catalog_value cccv
                  WHERE cccv.cross_chk_catalog_name::text = 'Method to Substitute Data Code'::text) d1 ON ptm.value2 = d1.method_cd
          WHERE ptm.cross_chk_catalog_name::text = 'Method Parameter to Method to System Type'::text) d2 ON p.value1 = d2.parameter_cd
  WHERE p.cross_chk_catalog_name::text = 'Parameter to Category'::text AND p.value2 = 'METHOD'::text
  ORDER BY p.value1, d2.method_cd, d2.sub_data_cd;
