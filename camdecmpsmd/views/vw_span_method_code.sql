-- View: camdecmpsmd.vw_span_method_code

-- DROP VIEW camdecmpsmd.vw_span_method_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_span_method_code
 AS
 SELECT span_method_code.span_method_cd,
    span_method_code.span_method_cd_description
   FROM camdecmpsmd.span_method_code;
