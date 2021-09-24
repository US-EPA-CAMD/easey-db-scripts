-- View: camdecmpsmd.vw_equation_code

-- DROP VIEW camdecmpsmd.vw_equation_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_equation_code
 AS
 SELECT equation_code.equation_cd,
    equation_code.equation_cd_description,
    equation_code.moisture_ind
   FROM camdecmpsmd.equation_code;
