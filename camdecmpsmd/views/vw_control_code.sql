-- View: camdecmpsmd.vw_control_code

-- DROP VIEW camdecmpsmd.vw_control_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_control_code
 AS
 SELECT control_code.control_cd,
    control_code.control_equip_param_cd AS ce_param,
    control_code.control_description AS control_cd_description
   FROM camdecmpsmd.control_code;
