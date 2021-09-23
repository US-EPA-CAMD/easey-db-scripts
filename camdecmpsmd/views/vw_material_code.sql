-- View: camdecmpsmd.vw_material_code

-- DROP VIEW camdecmpsmd.vw_material_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_material_code
 AS
 SELECT material_code.material_cd,
    material_code.material_code_description
   FROM camdecmpsmd.material_code;