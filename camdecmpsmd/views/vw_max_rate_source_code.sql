-- View: camdecmpsmd.vw_max_rate_source_code

-- DROP VIEW camdecmpsmd.vw_max_rate_source_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_max_rate_source_code
 AS
 SELECT max_rate_source_code.max_rate_source_cd,
    max_rate_source_code.max_rate_source_cd_description
   FROM camdecmpsmd.max_rate_source_code;
