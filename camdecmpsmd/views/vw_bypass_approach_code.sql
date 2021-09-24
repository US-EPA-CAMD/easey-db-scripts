-- View: camdecmpsmd.vw_bypass_approach_code

-- DROP VIEW camdecmpsmd.vw_bypass_approach_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_bypass_approach_code
 AS
 SELECT bypass_approach_code.bypass_approach_cd,
    bypass_approach_code.bypass_approach_cd_description
   FROM camdecmpsmd.bypass_approach_code;