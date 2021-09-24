-- View: camdecmpsmd.vw_default_purpose_code

-- DROP VIEW camdecmpsmd.vw_default_purpose_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_default_purpose_code
 AS
 SELECT default_purpose_code.default_purpose_cd,
    default_purpose_code.def_purpose_cd_description
   FROM camdecmpsmd.default_purpose_code;
