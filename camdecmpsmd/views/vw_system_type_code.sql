-- View: camdecmpsmd.vw_system_type_code

-- DROP VIEW camdecmpsmd.vw_system_type_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_system_type_code
 AS
 SELECT system_type_code.sys_type_cd,
    system_type_code.sys_type_description,
    system_type_code.parameter_cd
   FROM camdecmpsmd.system_type_code;
