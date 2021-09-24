-- View: camdecmpsmd.vw_substitute_data_code

-- DROP VIEW camdecmpsmd.vw_substitute_data_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_substitute_data_code
 AS
 SELECT substitute_data_code.sub_data_cd,
    substitute_data_code.sub_data_cd_description
   FROM camdecmpsmd.substitute_data_code;
