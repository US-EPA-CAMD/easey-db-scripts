-- View: camdecmpsmd.vw_check_type_code

-- DROP VIEW camdecmpsmd.vw_check_type_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_check_type_code
 AS
 SELECT check_type_code.check_type_cd,
    check_type_code.check_type_cd_description
   FROM camdecmpsmd.check_type_code;
