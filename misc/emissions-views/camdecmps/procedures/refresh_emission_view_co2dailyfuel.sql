-- PROCEDURE: camdecmps.refresh_emission_view_co2dailyfuel()

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_co2dailyfuel();

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_co2dailyfuel()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	TRUNCATE camdecmps.EMISSION_VIEW_CO2DAILYFUEL RESTART IDENTITY;

	INSERT INTO camdecmps.EMISSION_VIEW_CO2DAILYFUEL(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE,
		RPT_TOTAL_DAILY_CO2_MASS,
		RPT_UNADJUSTED_CO2_MASS,
		RPT_ADJUSTED_DAILY_CO2_MASS,
		RPT_SORBENT_RLTD_CO2_MASS,
		FUEL_CD,
		DAILY_FUEL_FEED,
		CARBON_CONTENT_USED,
		FUEL_CARBON_BURNED,
		CALC_FUEL_CARBON_BURNED,
		TOTAL_CARBON_BURNED,
		CALC_TOTAL_DAILY_EMISSION,
		ERROR_CODES
	)
	SELECT DISTINCT
		mpl.MON_PLAN_ID,
		mpl.MON_LOC_ID, 
		evl.RPT_PERIOD_ID, 
		dem.BEGIN_DATE AS DATE, 
		dem.TOTAL_DAILY_EMISSION AS RPT_TOTAL_DAILY_CO2_MASS, 
		dem.UNADJUSTED_DAILY_EMISSION AS RPT_UNADJUSTED_CO2_MASS,
		dem.ADJUSTED_DAILY_EMISSION AS RPT_ADJUSTED_DAILY_CO2_MASS, 
		dem.SORBENT_MASS_EMISSION AS RPT_SORBENT_RLTD_CO2_MASS, 
		COALESCE(df.FUEL_CD, '') AS FUEL_CD,
		df.DAILY_FUEL_FEED,
		df.CARBON_CONTENT_USED,
		df.FUEL_CARBON_BURNED,
		df.CALC_FUEL_CARBON_BURNED, 
		dem.TOTAL_CARBON_BURNED,
		dem.CALC_TOTAL_DAILY_EMISSION,
		CASE
			WHEN (
				Max(
					CASE
						WHEN rul.RULE_CHECK_ID IS NULL THEN 0
						ELSE Coalesce(sev.SEVERITY_LEVEL, 0)
					END
				) > 0
			) THEN 'View Errors'
			ELSE null
		END AS ERROR_CODES
	FROM camdecmps.MONITOR_PLAN_LOCATION AS mpl
	LEFT OUTER JOIN camdecmps.EMISSION_EVALUATION evl 
		ON evl.MON_PLAN_ID = mpl.MON_PLAN_ID
	INNER JOIN camdecmps.DAILY_EMISSION dem 
		ON dem.MON_LOC_ID = mpl.MON_LOC_ID AND dem.RPT_PERIOD_ID = evl.RPT_PERIOD_ID AND dem.PARAMETER_CD = 'CO2M'
	LEFT OUTER JOIN camdecmps.DAILY_FUEL df 
		ON dem.DAILY_EMISSION_ID = df.DAILY_EMISSION_ID
	LEFT OUTER JOIN camdecmpsaux.CHECK_LOG log 
		ON log.CHK_SESSION_ID = evl.CHK_SESSION_ID AND log.MON_LOC_ID = mpl.MON_LOC_ID AND
		log.OP_BEGIN_DATE <= dem.BEGIN_DATE AND log.OP_END_DATE >= dem.BEGIN_DATE
	LEFT OUTER JOIN camdecmpsmd.CHECK_CATALOG_RESULT res 
		ON	res.CHECK_CATALOG_RESULT_ID = log.CHECK_CATALOG_RESULT_ID
	LEFT OUTER JOIN camdecmpsmd.SEVERITY_CODE sev 
		ON sev.SEVERITY_CD = log.SEVERITY_CD
	LEFT OUTER JOIN camdecmpsmd.RULE_CHECK rul 
		ON rul.RULE_CHECK_ID = log.RULE_CHECK_ID AND rul.CATEGORY_CD = 'CO2DAY'
	GROUP BY	mpl.MON_PLAN_ID, 
				mpl.MON_LOC_ID,  
				evl.RPT_PERIOD_ID,  
				dem.BEGIN_DATE, 
				dem.TOTAL_DAILY_EMISSION,  
				dem.UNADJUSTED_DAILY_EMISSION,
				dem.ADJUSTED_DAILY_EMISSION,  
				dem.SORBENT_MASS_EMISSION,
				df.FUEL_CD, df.DAILY_FUEL_FEED, df.CARBON_CONTENT_USED, df.FUEL_CARBON_BURNED, df.CALC_FUEL_CARBON_BURNED,
				dem.TOTAL_CARBON_BURNED, dem.CALC_TOTAL_DAILY_EMISSION;
END
$BODY$;