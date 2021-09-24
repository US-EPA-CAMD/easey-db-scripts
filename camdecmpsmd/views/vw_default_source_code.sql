-- View: camdecmpsmd.vw_default_source_code

-- DROP VIEW camdecmpsmd.vw_default_source_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_default_source_code
 AS
 SELECT default_source_code.default_source_cd,
    default_source_code.default_source_cd_description
   FROM camdecmpsmd.default_source_code;
