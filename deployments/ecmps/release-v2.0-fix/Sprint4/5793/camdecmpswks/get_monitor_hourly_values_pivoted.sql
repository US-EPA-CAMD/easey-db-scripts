CREATE OR REPLACE FUNCTION camdecmpswks.get_monitor_hourly_values_pivoted(monplanid character varying, rptperiodid numeric, parametercodes text[], parameterswithmoisture text[], moisturebasiscodes text[])
 RETURNS SETOF record
 LANGUAGE plpgsql
AS $function$
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
				FROM camdecmpswks.monitor_hrly_value
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
				  FROM camdecmpswks.monitor_hrly_value
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
$function$
