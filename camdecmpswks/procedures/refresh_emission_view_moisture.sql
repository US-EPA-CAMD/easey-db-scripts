-- PROCEDURE: camdecmpswks.refresh_emission_view_hicems(character varying, numeric)

-- DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_hicems(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_moisture(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camdecmpswks.EMISSION_VIEW_MOISTURE 
	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmpswks.EMISSION_VIEW_MOISTURE
           (MON_PLAN_ID
           ,MON_LOC_ID
           ,RPT_PERIOD_ID
           ,DATE_HOUR
           ,OP_TIME
           ,H2O_MODC
           ,H2O_PMA
           ,PCT_O2_WET
           ,O2_WET_MODC
           ,PCT_O2_DRY
           ,O2_DRY_MODC
           ,H2O_FORMULA_CD
           ,RPT_PCT_H2O
           ,CALC_PCT_H2O
           ,ERROR_CODES)
		
		SELECT DISTINCT
				HOD.MON_PLAN_ID, 
				HOD.MON_LOC_ID, 
				HOD.RPT_PERIOD_ID, 
				camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
				HOD.OP_TIME, 
				DHV.MODC_CD AS H2O_MODC,
				DHV.PCT_AVAILABLE AS H2O_PMA,
				WET_MHV.UNADJUSTED_HRLY_VALUE AS PCT_O2_WET,
				WET_MHV.MODC_CD AS O2_WET_MODC,
				DRY_MHV.UNADJUSTED_HRLY_VALUE AS PCT_O2_DRY,
				DRY_MHV.MODC_CD AS O2_DRY_MODC,
				MF.EQUATION_CD AS H2O_FORMULA_CD,
				DHV.ADJUSTED_HRLY_VALUE AS RPT_PCT_H2O,
				DHV.CALC_ADJUSTED_HRLY_VALUE AS CALC_PCT_H2O,
				HOD.ERROR_CODES
		FROM temp_hourly_errors AS HOD																    -- bugzilla 7120	
			INNER JOIN camdecmpswks.DERIVED_HRLY_VALUE AS DHV ON DHV.HOUR_ID = HOD.HOUR_ID AND DHV.PARAMETER_CD = 'H2O' and DHV.MODC_CD <> '40'
			LEFT OUTER JOIN camdecmpswks.MONITOR_FORMULA AS MF ON DHV.MON_FORM_ID = MF.MON_FORM_ID 
			LEFT OUTER JOIN camdecmpswks.MONITOR_HRLY_VALUE AS WET_MHV ON DHV.HOUR_ID = WET_MHV.HOUR_ID AND WET_MHV.PARAMETER_CD = 'O2C' AND WET_MHV.MOISTURE_BASIS = 'W'
			LEFT OUTER JOIN camdecmpswks.MONITOR_HRLY_VALUE AS DRY_MHV ON DHV.HOUR_ID = DRY_MHV.HOUR_ID AND DRY_MHV.PARAMETER_CD = 'O2C' AND DRY_MHV.MOISTURE_BASIS = 'D';
END
$BODY$;
