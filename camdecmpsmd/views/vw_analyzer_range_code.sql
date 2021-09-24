-- View: camdecmpsmd.vw_analyzer_range_code

-- DROP VIEW camdecmpsmd.vw_analyzer_range_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_analyzer_range_code
 AS
 SELECT analyzer_range_code.analyzer_range_cd,
    analyzer_range_code.analyzer_range_cd_description
   FROM camdecmpsmd.analyzer_range_code;
