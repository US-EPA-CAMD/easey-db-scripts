-- PROCEDURE: camdecmpswks.refresh_emission_view_so2cems(character varying, numeric)

-- DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_so2cems(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_hiunitstack(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camdecmpswks.EMISSION_VIEW_HIUNITSTACK 
		WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmpswks.EMISSION_VIEW_HIUNITSTACK
           (MON_PLAN_ID
           ,MON_LOC_ID
           ,RPT_PERIOD_ID
           ,DATE_HOUR
           ,OP_TIME
           ,UNIT_LOAD
           ,LOAD_UOM
           ,LOAD_RANGE
           ,COMMON_STACK_LOAD_RANGE
           ,HI_FORMULA_CD
           ,RPT_HI_RATE
           ,CALC_HI_RATE
           ,ERROR_CODES)
		
		SELECT DISTINCT
				HOD.MON_PLAN_ID, 
				HOD.MON_LOC_ID, 
				HOD.RPT_PERIOD_ID, 
				camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
				HOD.OP_TIME, 
				HOD.HR_LOAD AS UNIT_LOAD, 
		        HOD.LOAD_UOM_CD AS LOAD_UOM, 
				HOD.LOAD_RANGE, 
				HOD.COMMON_STACK_LOAD_RANGE, 
				MF.EQUATION_CD AS HI_FORMULA_CD, 
		        DHV.ADJUSTED_HRLY_VALUE AS RPT_HI_RATE, 
				DHV.CALC_ADJUSTED_HRLY_VALUE AS CALC_HI_RATE, 
				HOD.ERROR_CODES
		FROM temp_hourly_errors AS HOD 
				INNER JOIN camdecmpswks.DERIVED_HRLY_VALUE AS DHV ON HOD.HOUR_ID = DHV.HOUR_ID AND DHV.PARAMETER_CD = 'HI'
				LEFT OUTER JOIN camdecmpswks.MONITOR_HRLY_VALUE AS MHV ON HOD.HOUR_ID = MHV.HOUR_ID AND MHV.PARAMETER_CD = 'FLOW' 
				LEFT OUTER JOIN camdecmpswks.MONITOR_FORMULA AS MF ON DHV.MON_FORM_ID = MF.MON_FORM_ID
		WHERE MHV.PARAMETER_CD IS NULL;
END
$BODY$;