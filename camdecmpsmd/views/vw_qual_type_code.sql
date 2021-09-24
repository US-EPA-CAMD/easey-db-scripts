-- View: camdecmpsmd.vw_qual_type_code

-- DROP VIEW camdecmpsmd.vw_qual_type_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_qual_type_code
 AS
 SELECT qual_type_code.qual_type_cd,
    qual_type_code.qual_type_cd_description
   FROM camdecmpsmd.qual_type_code;
