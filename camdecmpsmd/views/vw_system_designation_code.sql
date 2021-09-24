-- View: camdecmpsmd.vw_system_designation_code

-- DROP VIEW camdecmpsmd.vw_system_designation_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_system_designation_code
 AS
 SELECT system_designation_code.sys_designation_cd,
    system_designation_code.sys_designation_cd_description
   FROM camdecmpsmd.system_designation_code;
