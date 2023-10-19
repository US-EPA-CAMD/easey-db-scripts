/*
--------------------------------------------------------------------------------
THIS FUNCTION PIVOTS THE MONITOR_HOURLY_VALUE TABLE
--------------------------------------------------------------------------------
*/
DROP FUNCTION IF EXISTS camdecmps.get_monitor_hourly_values_pivoted(text, numeric, text[], text[], text[]);
DROP FUNCTION IF EXISTS camdecmps.get_monitor_hourly_values_pivoted(character varying, numeric, text[], text[], text[]);

CREATE OR REPLACE FUNCTION camdecmps.get_monitor_hourly_values_pivoted(
	monplanid character varying,
	rptperiodid numeric,
	parameterCodes text[],
	parametersWithMoisture text[],
	moistureBasisCodes text[]
) RETURNS SETOF record
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	param text;
	sqlText text;
	moisture text;
	joinText text;
	columnText text;
	monlocids text[];
	selectList text := 'hour_id,
					mon_loc_id,
					rpt_period_id,
					adjusted_hrly_value,
					calc_adjusted_hrly_value,
					unadjusted_hrly_value,
					applicable_bias_adj_factor,
					pct_available,
					moisture_basis,
					modc_cd';
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
			%2$s.hour_id AS %2$s_hour_id,
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
					%2$s
				FROM camdecmps.monitor_hrly_value
				WHERE mon_loc_id = ANY(%3$L::text[]) AND rpt_period_id = %4$s AND parameter_cd = %5$L
			) AS %5$s
				ON %5$s.hour_id = HOD.hour_id
				AND %5$s.mon_loc_id = HOD.mon_loc_id
				AND %5$s.rpt_period_id = HOD.rpt_period_id'
		, joinText, selectList, monLocIds, rptPeriodId, param);
	END LOOP;

	FOREACH param IN ARRAY parametersWithMoisture
	LOOP
	   	FOREACH moisture IN ARRAY moistureBasisCodes
  		LOOP
			columnText = format(
				'%1$s,
				%2$s_%3$s.hour_id AS %2$s_%3$s_hour_id,
				%2$s_%3$s.adjusted_hrly_value AS %2$s_%3$s_adjusted_hrly_value,
				%2$s_%3$s.calc_adjusted_hrly_value AS %2$s_%3$s_calc_adjusted_hrly_value,
				%2$s_%3$s.unadjusted_hrly_value AS %2$s_%3$s_unadjusted_hrly_value,
				%2$s_%3$s.applicable_bias_adj_factor AS %2$s_%3$s_applicable_bias_adj_factor,
				%2$s_%3$s.pct_available AS %2$s_%3$s_pct_available,
				%2$s_%3$s.moisture_basis AS %2$s_%3$s_moisture_basis,
				%2$s_%3$s.modc_cd AS %2$s_%3$s_modc_cd'
			, columnText, param, moisture);

			joinText := format(
				'%1$s
				LEFT JOIN (
				  SELECT
					%2$s
				  FROM camdecmps.monitor_hrly_value
				  WHERE mon_loc_id = ANY(%3$L::text[]) AND rpt_period_id = %4$s
				  AND parameter_cd = %5$L AND moisture_basis = %6$L
				) AS %5$s_%6$s
				  ON %5$s_%6$s.hour_id = HOD.hour_id
				  AND %5$s_%6$s.mon_loc_id = HOD.mon_loc_id
				  AND %5$s_%6$s.rpt_period_id = HOD.rpt_period_id'
			  , joinText, selectList, monLocIds, rptPeriodId, param, moisture);
		END LOOP;
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
	columnText text := '';
BEGIN
	FOREACH param IN ARRAY parameterCodes
	LOOP
		columnText := format(
			'%1$s,
			%2$s_hour_id character varying,
			%2$s_adjusted_hrly_value numeric,
			%2$s_calc_adjusted_hrly_value numeric,
			%2$s_unadjusted_hrly_value numeric,
			%2$s_applicable_bias_adj_factor numeric,
			%2$s_pct_available numeric,
			%2$s_moisture_basis character varying,
			%2$s_modc_cd character varying'
		, columnText, param);
	END LOOP;
	
	sqlText := format('
		SELECT * FROM camdecmps.get_monitor_hourly_values_pivoted(
			%1$L, %2$s, %3$L::text[], ARRAY[]::text[], ARRAY[]::text[]
		) AS (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric
			%4$s
		);'
	, monplanid, rptperiodid, parameterCodes, columnText);

	RETURN QUERY EXECUTE sqlText;
END
$BODY$;

/*
--------------------------------------------------------------------------------
THIS IS HOW YOU USE THIS FUNCTION
--------------------------------------------------------------------------------
SELECT *
FROM camdecmps.get_monitor_hourly_values_pivoted(
  'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A'::text, 120, ARRAY['FLOW','H2O']
) AS MHV (
	hour_id character varying,
	mon_loc_id character varying,
	rpt_period_id numeric,

	flow_hour_id character varying,
	flow_adjusted_hrly_value numeric,
	flow_calc_adjusted_hrly_value numeric,
	flow_unadjusted_hrly_value numeric,
	flow_applicable_bias_adj_factor numeric,
	flow_pct_available numeric,
	flow_moisture_basis character varying,
	Flow_modc_cd character varying,

	h2o_hour_id character varying,
	h2o_adjusted_hrly_value numeric,
	h2o_calc_adjusted_hrly_value numeric,
	h2o_unadjusted_hrly_value numeric,
	h2o_applicable_bias_adj_factor numeric,
	h2o_pct_available numeric,
	h2o_moisture_basis character varying,
	h2o_modc_cd character varying
);

SELECT *
FROM camdecmps.get_monitor_hourly_values_pivoted(
  'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 120, ARRAY['FLOW','H2O'], ARRAY['O2'], ARRAY['D', 'W']
) AS MHV (
	hour_id character varying,
	mon_loc_id character varying,
	rpt_period_id numeric,

	flow_hour_id character varying,
	flow_adjusted_hrly_value numeric,
	flow_calc_adjusted_hrly_value numeric,
	flow_unadjusted_hrly_value numeric,
	flow_applicable_bias_adj_factor numeric,
	flow_pct_available numeric,
	flow_moisture_basis character varying,
	Flow_modc_cd character varying,

	h2o_hour_id character varying,
	h2o_adjusted_hrly_value numeric,
	h2o_calc_adjusted_hrly_value numeric,
	h2o_unadjusted_hrly_value numeric,
	h2o_applicable_bias_adj_factor numeric,
	h2o_pct_available numeric,
	h2o_moisture_basis character varying,
	h2o_modc_cd character varying,

	o2_d_hour_id character varying,
	o2_d_adjusted_hrly_value numeric,
	o2_d_calc_adjusted_hrly_value numeric,
	o2_d_unadjusted_hrly_value numeric,
	o2_d_applicable_bias_adj_factor numeric,
	o2_d_pct_available numeric,
	o2_d_moisture_basis character varying,
	o2_d_modc_cd character varying,

	o2_w_hour_id character varying,
	o2_w_adjusted_hrly_value numeric,
	o2_w_calc_adjusted_hrly_value numeric,
	o2_w_unadjusted_hrly_value numeric,
	o2_w_applicable_bias_adj_factor numeric,
	o2_w_pct_available numeric,
	o2_w_moisture_basis character varying,
	o2_w_modc_cd character varying
);
*/
