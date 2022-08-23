CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_formula (mon_form_id, mon_plan_id, mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, fac_id, location_name, equation_cd_description, moisture_ind) AS
SELECT
    mon_form_id, mon_plan_id, vwML.mon_loc_id, parameter_cd, ec.equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, fac_id, location_name, equation_cd_description, moisture_ind
    FROM camdecmpswks.monitor_formula mf
    INNER JOIN camdecmpswks.vw_mp_monitor_location vwML
        ON mf.mon_loc_id = vwML.mon_loc_id
    LEFT OUTER JOIN camdecmpsmd.equation_code ec
        ON mf.equation_cd = ec.equation_cd;