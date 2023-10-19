/*
--------------------------------------------------------------------------------
THIS FUNCTION PIVOTS THE DERIVED_HOURLY_VALUE TABLE
--------------------------------------------------------------------------------
*/
DROP FUNCTION IF EXISTS camdecmpswks.get_derived_hourly_values_pivoted(text, numeric, text[]);
DROP FUNCTION IF EXISTS camdecmpswks.get_derived_hourly_values_pivoted(character varying, numeric, text[]);

CREATE OR REPLACE FUNCTION camdecmpswks.get_derived_hourly_values_pivoted(
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
			HOD.hour_id,
			HOD.mon_loc_id,
			HOD.rpt_period_id';
	
	joinText := 'FROM camdecmpswks.hrly_op_data AS HOD';

	FOREACH param IN ARRAY parameterCodes
	LOOP
		columnText = format(
			'%1$s,
			%2$s.hour_id AS %2$s_hour_id,
			%2$s.mon_form_id AS %2$s_mon_form_id,
			%2$s.adjusted_hrly_value AS %2$s_adjusted_hrly_value,
			%2$s.calc_adjusted_hrly_value AS %2$s_calc_adjusted_hrly_value,
			%2$s.unadjusted_hrly_value AS %2$s_unadjusted_hrly_value,
			%2$s.calc_unadjusted_hrly_value AS %2$s_calc_unadjusted_hrly_value,
			%2$s.applicable_bias_adj_factor AS %2$s_applicable_bias_adj_factor,
			%2$s.calc_pct_moisture AS %2$s_calc_pct_moisture,
			%2$s.calc_pct_diluent AS %2$s_calc_pct_diluent,
			%2$s.pct_available AS %2$s_pct_available,
 			%2$s.segment_num AS %2$s_segment_num,
 			%2$s.operating_condition_cd AS %2$s_operating_condition_cd,
 			%2$s.fuel_cd AS %2$s_fuel_cd,
 			%2$s.modc_cd AS %2$s_modc_cd'
		, columnText, param);
		
		joinText := format(
			'%1$s
			LEFT JOIN (
				SELECT
					hour_id,
					mon_loc_id,
					rpt_period_id,
					mon_form_id,
					adjusted_hrly_value,
					calc_adjusted_hrly_value,
					unadjusted_hrly_value,
					calc_unadjusted_hrly_value,
					applicable_bias_adj_factor,
					calc_pct_moisture,
					calc_pct_diluent,
					pct_available,
					segment_num,
					operating_condition_cd,
					fuel_cd,
					modc_cd
				FROM camdecmpswks.derived_hrly_value
				WHERE mon_loc_id = ANY(%2$L::text[]) AND rpt_period_id = %3$s AND parameter_cd = %4$L
			) AS %4$s
				ON %4$s.hour_id = HOD.hour_id
				AND %4$s.mon_loc_id = HOD.mon_loc_id
				AND %4$s.rpt_period_id = HOD.rpt_period_id'
		, joinText, monLocIds, rptPeriodId, param);
	END LOOP;

	sqlText = format(
		'%1$s
		%2$s
		WHERE HOD.mon_loc_id = ANY(%3$L::text[]) AND HOD.rpt_period_id = %4$s
		ORDER BY HOD.MON_LOC_ID;'
	, columnText, joinText, monLocIds, rptPeriodId);

	RETURN QUERY EXECUTE sqlText;
END
$BODY$;

/*
--------------------------------------------------------------------------------
THIS IS HOW YOU USE THIS FUNCTION
--------------------------------------------------------------------------------
SELECT *
FROM camdecmpswks.get_derived_hourly_values_pivoted(
  'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 120, ARRAY['HI','CO2']
) AS DHV (
	hour_id character varying,
	mon_loc_id character varying,
	rpt_period_id numeric,

	hi_hour_id character varying,
	hi_mon_form_id character varying,
	hi_adjusted_hrly_value numeric,
	hi_calc_adjusted_hrly_value numeric,
	hi_unadjusted_hrly_value numeric,
	hi_calc_unadjusted_hrly_value numeric,
	hi_applicable_bias_adj_factor numeric,
	hi_calc_pct_moisture numeric,
	hi_calc_pct_diluent numeric,
	hi_pct_available numeric,
	hi_segment_num numeric,
	hi_operating_condition_cd character varying,
	hi_fuel_cd character varying,
	hi_modc_cd character varying,

	co2_hour_id character varying,
	co2_mon_form_id character varying,
	co2_adjusted_hrly_value numeric,
	co2_calc_adjusted_hrly_value numeric,
	co2_unadjusted_hrly_value numeric,
	co2_calc_unadjusted_hrly_value numeric,
	co2_applicable_bias_adj_factor numeric,
	co2_calc_pct_moisture numeric,
	co2_calc_pct_diluent numeric,
	co2_pct_available numeric,
	co2_segment_num numeric,
	co2_operating_condition_cd character varying,
	co2_fuel_cd character varying,
	co2_modc_cd character varying
);
*/
