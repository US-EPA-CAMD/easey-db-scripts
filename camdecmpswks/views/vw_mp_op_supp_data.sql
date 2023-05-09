-- View: camdecmpswks.vw_mp_op_supp_data

DROP VIEW IF EXISTS camdecmpswks.vw_mp_op_supp_data;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_op_supp_data
AS
	SELECT
		sd.op_supp_data_id,
    	sd.mon_loc_id,
		ml.mon_plan_id,
		sd.fuel_cd,
		sd.op_type_cd,
		sd.rpt_period_id,
		sd.op_value,
		rp.calendar_year,
		rp.quarter,
		sd.op_type_cd AS parameter_cd,
		rp.begin_date AS quarter_begin_date,
		rp.end_date AS quarter_end_date,
		4::numeric * rp.calendar_year + rp.quarter AS quarter_ord
	FROM camdecmpswks.operating_supp_data sd
	LEFT JOIN camdecmpswks.vw_mp_location ml ON sd.mon_loc_id::text = ml.mon_loc_id::text
	LEFT JOIN camdecmpsmd.reporting_period rp ON sd.rpt_period_id = rp.rpt_period_id;
