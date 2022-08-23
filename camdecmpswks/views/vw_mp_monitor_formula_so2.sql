CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_formula_so2 (mon_form_id, mon_plan_id, mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation) AS
SELECT
    mon_form_id, mon_plan_id, vwML.mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation
    FROM camdecmpswks.monitor_formula mf
    INNER JOIN camdecmpswks.vw_mp_monitor_location vwML
        ON mf.mon_loc_id = vwML.mon_loc_id
    WHERE (mf.parameter_cd = 'SO2');