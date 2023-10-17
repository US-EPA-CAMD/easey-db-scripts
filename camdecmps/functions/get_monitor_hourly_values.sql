/*
--------------------------------------------------------------------------------
THIS FUNCTION PIVOTS THE MONITOR_HOURLY_TABLE
--------------------------------------------------------------------------------
*/
DROP FUNCTION IF EXISTS camdecmps.get_monitor_hourly_values_pivoted(text, numeric, text[]);

CREATE OR REPLACE FUNCTION camdecmps.get_monitor_hourly_values_pivoted(
	monplanid text,
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
		FROM camdecmps.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	columnText :=
		'SELECT
			HOD.hour_id,
			HOD.mon_loc_id,
			HOD.rpt_period_id';
	
	joinText := 'FROM camdecmps.hrly_op_data AS HOD';

	FOREACH param IN ARRAY parameterCodes
	LOOP
		columnText = format(
			'%1$s,
			%2$s.adjusted_hrly_value AS %2$s_adjusted_hrly_value,
			%2$s.calc_adjusted_hrly_value AS %2$s_calc_adjusted_hrly_value,
			%2$s.unadjusted_hrly_value AS %2$s_unadjusted_hrly_value,
			%2$s.applicable_bias_adj_factor AS %2$s_applicable_bias_adj_factor,
			%2$s.pct_available AS %2$s_pct_available,
			%2$s.moisture_basis AS %2$s_moisture_basis,
 			%2$s.modc_cd AS %2$s_modc_cd'
		, columnText, param);
		
		joinText := format(
			'%1$s
			LEFT JOIN (
				SELECT
					hour_id,
					mon_loc_id,
					rpt_period_id,
					adjusted_hrly_value,
					calc_adjusted_hrly_value,
					unadjusted_hrly_value,
					applicable_bias_adj_factor,
					pct_available,
					moisture_basis,
					modc_cd
				FROM camdecmps.monitor_hrly_value
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
		ORDER BY HOD.mon_loc_id;'
	, columnText, joinText, monLocIds, rptPeriodId);

	RETURN QUERY EXECUTE sqlText;
END
$BODY$;

/*
--------------------------------------------------------------------------------
THIS IS HOW YOU USE THIS FUNCTION
--------------------------------------------------------------------------------
SELECT *
FROM camdecmps.get_monitor_hourly_values_pivoted(
  'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 120, ARRAY['FLOW','H2O','CO2C','SO2C']
) AS MHV (
	hour_id character varying,
	mon_loc_id character varying,
	rpt_period_id numeric,

	flow_adjusted_hrly_value numeric,
	flow_calc_adjusted_hrly_value numeric,
	flow_unadjusted_hrly_value numeric,
	flow_applicable_bias_adj_factor numeric,
	flow_pct_available numeric,
	flow_moisture_basis character varying,
	Flow_modc_cd character varying,

	h2o_adjusted_hrly_value numeric,
	h2o_calc_adjusted_hrly_value numeric,
	h2o_unadjusted_hrly_value numeric,
	h2o_applicable_bias_adj_factor numeric,
	h2o_pct_available numeric,
	h2o_moisture_basis character varying,
	h2o_modc_cd character varying,

	co2c_adjusted_hrly_value numeric,
	co2c_calc_adjusted_hrly_value numeric,
	co2c_unadjusted_hrly_value numeric,
	co2c_applicable_bias_adj_factor numeric,
	co2c_pct_available numeric,
	co2c_moisture_basis character varying,
	co2c_modc_cd character varying,

	so2c_adjusted_hrly_value numeric,
	so2c_calc_adjusted_hrly_value numeric,
	so2c_unadjusted_hrly_value numeric,
	so2c_applicable_bias_adj_factor numeric,
	so2c_pct_available numeric,
	so2c_moisture_basis character varying,
	so2c_modc_cd character varying
);
*/
