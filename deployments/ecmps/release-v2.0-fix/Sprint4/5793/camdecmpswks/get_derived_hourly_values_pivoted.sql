CREATE OR REPLACE FUNCTION camdecmpswks.get_derived_hourly_values_pivoted(monplanid character varying, rptperiodid numeric, parametercodes text[])
 RETURNS SETOF record
 LANGUAGE plpgsql
AS $function$
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
			%2$s.mon_sys_id AS %2$s_mon_sys_id,
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
					mon_sys_id,
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
$function$
