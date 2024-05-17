CREATE OR REPLACE FUNCTION camdecmps.get_hourly_param_fuel_flow_pivoted(monplanid character varying, rptperiodid numeric, parametercodes text[])
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
		FROM camdecmps.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	columnText :=
		'SELECT
			HFF.hrly_fuel_flow_id,
			HFF.hour_id,
			HFF.mon_loc_id,
			HFF.rpt_period_id';
	
	joinText := 'FROM camdecmps.hrly_fuel_flow AS HFF';

	FOREACH param IN ARRAY parameterCodes
	LOOP
		columnText = format(
			'%1$s,
			%2$s.hrly_fuel_flow_id AS %2$s_hrly_fuel_flow_id,
			%2$s.mon_sys_id AS %2$s_mon_sys_id,
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
					mon_sys_id,
					mon_form_id,
					param_val_fuel,
					calc_param_val_fuel,
					segment_num,
					sample_type_cd,
					parameter_uom_cd,
					operating_condition_cd
				FROM camdecmps.hrly_param_fuel_flow
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
$function$
