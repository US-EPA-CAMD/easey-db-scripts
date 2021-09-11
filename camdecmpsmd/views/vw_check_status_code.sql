-- View: camdecmpsmd.vw_check_status_code

-- DROP VIEW camdecmpsmd.vw_check_status_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_check_status_code
 AS
 SELECT check_status_code.check_status_cd,
    check_status_code.check_status_cd_description,
    check_status_code.check_uses_flg,
    check_status_code.code_uses_flg,
    check_status_code.test_uses_flg
   FROM camdecmpsmd.check_status_code;
