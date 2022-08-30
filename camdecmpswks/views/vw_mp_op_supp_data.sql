CREATE OR REPLACE VIEW camdecmpswks.vw_mp_op_supp_data (op_supp_data_id, mon_loc_id, mon_plan_id, fuel_cd, op_type_cd, camdecmpswks, op_value, calendar_year, quarter, parameter_cd, quarter_begin_date, quarter_end_date, quarter_ord) AS
SELECT
    sd.op_supp_data_id, sd.mon_loc_id, ml.mon_plan_id, sd.fuel_cd, sd.op_type_cd, sd.camdecmpswks, sd.op_value, rp.calendar_year, rp.quarter, sd.op_type_cd AS parameter_cd, rp.begin_date AS quarter_begin_date, rp.end_date AS quarter_end_date, (4 * rp.calendar_year + rp.quarter) AS quarter_ord
    FROM camdempswks.operating_supp_data AS sd
    LEFT OUTER JOIN camdecmpswks.vw_mp_location AS ml
        ON sd.mon_loc_id = ml.mon_loc_id
    LEFT OUTER JOIN camdecmpswks.reporting_period AS rp
        ON sd.camdecmpswks = rp.camdecmpswks;