-- View: camdecmpsmd.vw_component_type_code

-- DROP VIEW camdecmpsmd.vw_component_type_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_component_type_code
 AS
 SELECT component_type_code.component_type_cd,
    component_type_code.component_type_cd_description,
    component_type_code.span_indicator,
    component_type_code.parameter_cd
   FROM camdecmpsmd.component_type_code;
