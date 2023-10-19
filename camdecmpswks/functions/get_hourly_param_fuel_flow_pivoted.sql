/*
--------------------------------------------------------------------------------
THIS FUNCTION PIVOTS THE HRLY_PARAM_FUEL_FLOW TABLE
--------------------------------------------------------------------------------
*/
DROP FUNCTION IF EXISTS camdecmpswks.get_hourly_param_fuel_flow_pivoted(text, numeric, text[]);
DROP FUNCTION IF EXISTS camdecmpswks.get_hourly_param_fuel_flow_pivoted(character varying, numeric, text[]);

CREATE OR REPLACE FUNCTION camdecmpswks.get_hourly_param_fuel_flow_pivoted(
	monplanid character varying,
	rptperiodid numeric,
	parameterCodes text[]
) RETURNS SETOF record
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	param text;
	sqlText text;
	joinText text;	
	columnText text;
  monlocids text[];
BEGIN
  SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	columnText :=
		'SELECT
			HFF.hrly_fuel_flow_id,
			HFF.hour_id,
			HFF.mon_loc_id,
			HFF.rpt_period_id';
	
	joinText := 'FROM camdecmpswks.hrly_fuel_flow AS HFF';

	FOREACH param IN ARRAY parameterCodes
	LOOP
		columnText = format(
			'%1$s,
			%2$s.hrly_fuel_flow_id AS %2$s_hrly_fuel_flow_id,
			%2$s.mon_form_id AS %2$s_mon_form_id,
			%2$s.param_val_fuel AS %2$s_param_val_fuel,
			%2$s.calc_param_val_fuel AS %2$s_calc_param_val_fuel,
 			%2$s.segment_num AS %2$s_segment_num,
 			%2$s.sample_type_cd AS %2$s_sample_type_cd,
 			%2$s.parameter_uom_cd AS %2$s_parameter_uom_cd,
 			%2$s.operating_condition_cd AS %2$s_operating_condition_cd'
		, columnText, param);
		
		joinText := format(
			'%1$s
			LEFT JOIN (
				SELECT
					hrly_fuel_flow_id,
					mon_loc_id,
					rpt_period_id,
					mon_form_id,
					param_val_fuel,
					calc_param_val_fuel,
					segment_num,
					sample_type_cd,
					parameter_uom_cd,
					operating_condition_cd
				FROM camdecmpswks.hrly_param_fuel_flow
				WHERE mon_loc_id = ANY(%2$L::text[]) AND rpt_period_id = %3$s AND parameter_cd = %4$L
			) AS %4$s
				ON %4$s.hrly_fuel_flow_id = HFF.hrly_fuel_flow_id
				AND %4$s.mon_loc_id = HFF.mon_loc_id
				AND %4$s.rpt_period_id = HFF.rpt_period_id'
		, joinText, monLocIds, rptPeriodId, param);
	END LOOP;

	sqlText = format(
		'%1$s
		%2$s
		WHERE HFF.mon_loc_id = ANY(%3$L::text[]) AND HFF.rpt_period_id = %4$s
		ORDER BY HFF.MON_LOC_ID;'
	, columnText, joinText, monLocIds, rptPeriodId);

	RETURN QUERY EXECUTE sqlText;
END
$BODY$;

/*
--------------------------------------------------------------------------------
THIS IS HOW YOU USE THIS FUNCTION
--------------------------------------------------------------------------------
SELECT *
FROM camdecmpswks.get_hourly_param_fuel_flow_pivoted(
  'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 120, ARRAY['HI','CO2','FC']
) AS HPFF (
	hrly_fuel_flow_id character varying,
	hour_id character varying,
	mon_loc_id character varying,
	rpt_period_id numeric,

	hi_mon_form_id character varying,
	hi_param_val_fuel numeric,
	hi_calc_param_val_fuel numeric,
	hi_segment_num numeric,
	hi_sample_type_cd character varying,
	hi_parameter_uom_cd character varying,
	hi_operating_condition_cd character varying,

	co2_mon_form_id character varying,
	co2_param_val_fuel numeric,
	co2_calc_param_val_fuel numeric,
	co2_segment_num numeric,
	co2_sample_type_cd character varying,
	co2_parameter_uom_cd character varying,
	co2_operating_condition_cd character varying,

	fc_mon_form_id character varying,
	fc_param_val_fuel numeric,
	fc_calc_param_val_fuel numeric,
	fc_segment_num numeric,
	fc_sample_type_cd character varying,
	fc_parameter_uom_cd character varying,
	fc_operating_condition_cd character varying
);
*/
