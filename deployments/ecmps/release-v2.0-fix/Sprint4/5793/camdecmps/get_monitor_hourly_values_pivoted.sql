CREATE OR REPLACE FUNCTION camdecmps.get_monitor_hourly_values_pivoted(monplanid text, rptperiodid numeric, parametercodes text[])
 RETURNS SETOF record
 LANGUAGE plpgsql
AS $function$
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
$function$
