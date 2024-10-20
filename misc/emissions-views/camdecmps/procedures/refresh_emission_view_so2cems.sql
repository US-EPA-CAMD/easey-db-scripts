-- PROCEDURE: camdecmps.refresh_emission_view_so2cems()

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_so2cems();

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_so2cems()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	TRUNCATE camdecmps.EMISSION_VIEW_SO2CEMS RESTART IDENTITY;

	INSERT INTO camdecmps.EMISSION_VIEW_SO2CEMS(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		UNADJ_SO2,
		SO2_BAF,
		RPT_ADJ_SO2,
		CALC_ADJ_SO2,
		SO2_MODC,
		SO2_PMA,
		UNADJ_FLOW,
		FLOW_BAF,
		RPT_ADJ_FLOW,
		ADJ_FLOW_USED,
		FLOW_MODC,
		FLOW_PMA,
		PCT_H2O_USED,
		SOURCE_H2O_VALUE,
		SO2_FORMULA_CD,
		RPT_SO2_MASS_RATE,
		CALC_SO2_MASS_RATE,
		CALC_HI_RATE,
		DEFAULT_SO2_EMISSION_RATE,
		ERROR_CODES
	)
	SELECT DISTINCT
		HOD.MON_PLAN_ID, 
		HOD.MON_LOC_ID, 
		HOD.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
		HOD.OP_TIME, 
		HOD.HR_LOAD AS UNIT_LOAD, 
		HOD.LOAD_UOM_CD AS LOAD_UOM, 
		SO2C_MHV.UNADJUSTED_HRLY_VALUE AS UNADJ_SO2, 
		SO2C_MHV.APPLICABLE_BIAS_ADJ_FACTOR AS SO2_BAF, 
		SO2C_MHV.ADJUSTED_HRLY_VALUE AS RPT_ADJ_SO2, 
		SO2C_MHV.CALC_ADJUSTED_HRLY_VALUE  AS CALC_ADJ_SO2, 
		SO2C_MHV.MODC_CD AS SO2_MODC, 
		SO2C_MHV.PCT_AVAILABLE AS SO2_PMA,
		FLOW_MHV.UNADJUSTED_HRLY_VALUE AS UNADJ_FLOW, 
		FLOW_MHV.APPLICABLE_BIAS_ADJ_FACTOR AS FLOW_BAF, 
		FLOW_MHV.ADJUSTED_HRLY_VALUE AS RPT_ADJ_FLOW, 
		FLOW_MHV.CALC_ADJUSTED_HRLY_VALUE AS ADJ_FLOW_USED, 
		FLOW_MHV.MODC_CD AS FLOW_MODC, 
		FLOW_MHV.PCT_AVAILABLE AS FLOW_PMA,
		DHV.CALC_PCT_MOISTURE AS PCT_H2O_USED, 
		CASE 
			WHEN (DHV.CALC_PCT_MOISTURE IS NOT NULL) THEN 
				CASE 
					WHEN (H2O_DHV.MODC_CD IS NOT NULL) THEN H2O_DHV.MODC_CD 
					WHEN (H2O_MHV.MODC_CD IS NOT NULL) THEN H2O_MHV.MODC_CD 
					ELSE 'DF'
				END 
			ELSE NULL
		END AS SOURCE_H2O_VALUE, 
		MF.EQUATION_CD AS SO2_FORMULA_CD, 
		DHV.ADJUSTED_HRLY_VALUE AS RPT_SO2_MASS_RATE, 
		DHV.CALC_ADJUSTED_HRLY_VALUE AS CALC_SO2_MASS_RATE, 
		CASE (MF.EQUATION_CD) WHEN 'F-23' THEN HI_DHV.CALC_ADJUSTED_HRLY_VALUE END AS CALC_HI_RATE, 
		CASE (MF.EQUATION_CD) WHEN 'F-23' THEN Coalesce(SO2R_DHV.ADJUSTED_HRLY_VALUE, camdecmps.emissions_get_default_so2_rate(HOD.MON_LOC_ID, HOD.BEGIN_DATE, HOD.BEGIN_HOUR)) END AS DEFAULT_SO2_EMISSION_RATE,
		HOD.ERROR_CODES
	FROM temp_hourly_test_errors AS HOD 
	INNER JOIN camdecmps.DERIVED_HRLY_VALUE  DHV 
		ON DHV.HOUR_ID = HOD.HOUR_ID AND DHV.PARAMETER_CD = 'SO2' 
	INNER JOIN camdecmps.MONITOR_HRLY_VALUE  FLOW_MHV 
		ON HOD.HOUR_ID = FLOW_MHV.HOUR_ID AND FLOW_MHV.PARAMETER_CD = 'FLOW'
	LEFT OUTER JOIN camdecmps.MONITOR_HRLY_VALUE  SO2C_MHV 
		ON HOD.HOUR_ID = SO2C_MHV.HOUR_ID AND SO2C_MHV.PARAMETER_CD = 'SO2C' 		 
	LEFT OUTER JOIN camdecmps.MONITOR_FORMULA  MF 
		ON DHV.MON_FORM_ID = MF.MON_FORM_ID 
	LEFT OUTER JOIN camdecmps.MONITOR_HRLY_VALUE  H2O_MHV 
		ON DHV.HOUR_ID = H2O_MHV.HOUR_ID AND H2O_MHV.PARAMETER_CD = 'H2O' 
	LEFT OUTER JOIN camdecmps.DERIVED_HRLY_VALUE  H2O_DHV 
		ON DHV.HOUR_ID = H2O_DHV.HOUR_ID AND H2O_DHV.PARAMETER_CD = 'H2O' 
	LEFT OUTER JOIN camdecmps.MONITOR_DEFAULT  H2O_MD 
		ON HOD.MON_LOC_ID = H2O_MD.MON_LOC_ID AND H2O_MD.DEFAULT_PURPOSE_CD = 'PM' AND H2O_MD.PARAMETER_CD = 'H2O' 
		AND (camdecmps.emissions_monitor_default_active(H2O_MD.BEGIN_DATE, H2O_MD.BEGIN_HOUR, H2O_MD.END_DATE, H2O_MD.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1)
	LEFT OUTER JOIN camdecmps.DERIVED_HRLY_VALUE  HI_DHV 
		ON DHV.HOUR_ID = HI_DHV.HOUR_ID AND HI_DHV.PARAMETER_CD = 'HI' 
	LEFT OUTER JOIN camdecmps.DERIVED_HRLY_VALUE  SO2R_DHV 
		ON DHV.HOUR_ID = SO2R_DHV.HOUR_ID AND SO2R_DHV.PARAMETER_CD = 'SO2R';
END
$BODY$;
