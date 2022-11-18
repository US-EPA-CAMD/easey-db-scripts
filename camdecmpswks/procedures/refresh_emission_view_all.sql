-- PROCEDURE: camdecmpswks.refresh_emission_view_all(character varying, integer)

-- DROP PROCEDURE camdecmpswks.refresh_emission_view_all(character varying, integer);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_all(
	v_mon_plan_id character varying,
	v_rpt_period_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

    DELETE FROM camdecmpswks.EMISSION_VIEW_ALL 
	WHERE MON_PLAN_ID = v_MON_PLAN_ID 
	  AND RPT_PERIOD_ID = v_RPT_PERIOD_ID;

    INSERT INTO camdecmpswks.EMISSION_VIEW_ALL
           (	MON_PLAN_ID,
				MON_LOC_ID,
				RPT_PERIOD_ID,
				HOUR_ID,
				DATE_HOUR,
				OP_TIME,
				UNIT_LOAD,
				LOAD_UOM,
				HI_FORMULA_cd,
				RPT_HI_RATE,
				CALC_HI_RATE,
				SO2_FORMULA_cd,
				RPT_SO2_MASS_RATE,
				CALC_SO2_MASS_RATE,
				nox_rate_formula_cd,
				RPT_ADJ_NOX_RATE,
				CALC_ADJ_NOX_RATE,
				nox_mass_formula_cd,
				RPT_NOX_MASS,
				CALC_NOX_MASS,
				CO2_FORMULA_cd,
				RPT_CO2_MASS_RATE,
				CALC_CO2_MASS_RATE,
				-- Flow fields for bugzilla 9560
				ADJ_FLOW_USED, RPT_ADJ_FLOW, UNADJ_FLOW,
				-- always have the errors
				ERROR_CODES
            )
            SELECT DISTINCT	
				hod.MON_PLAN_ID, 
				hod.MON_LOC_ID, 
				hod.RPT_PERIOD_ID,
				hod.HOUR_ID,
				camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
				hod.OP_TIME,
				hod.HR_LOAD,
				hod.LOAD_UOM_CD,
				-- PARAMETER_CD='HI'
				mf_hi.EQUATION_CD,
				dhv_hi.ADJUSTED_HRLY_VALUE,
				dhv_hi.CALC_ADJUSTED_HRLY_VALUE,
				-- PARAMETER_CD='SO2'
				mf_SO2.EQUATION_CD,
				dhv_SO2.ADJUSTED_HRLY_VALUE,
				dhv_SO2.CALC_ADJUSTED_HRLY_VALUE,
				-- PARAMETER_CD='NOXR'
				mf_NOXR.EQUATION_CD,
				dhv_NOXR.ADJUSTED_HRLY_VALUE,
				dhv_NOXR.CALC_ADJUSTED_HRLY_VALUE,
				-- PARAMETER_CD='NOX'
				mf_NOX.EQUATION_CD,
				dhv_NOX.ADJUSTED_HRLY_VALUE,
				dhv_NOX.CALC_ADJUSTED_HRLY_VALUE,
				-- PARAMETER_CD='CO2'
				mf_CO2.EQUATION_CD,
				dhv_CO2.ADJUSTED_HRLY_VALUE,
				dhv_CO2.CALC_ADJUSTED_HRLY_VALUE,
				-- Flow fields for bugzilla 9560
				FLOW_MHV.CALC_ADJUSTED_HRLY_VALUE AS ADJ_FLOW_USED,
				FLOW_MHV.ADJUSTED_HRLY_VALUE AS RPT_ADJ_FLOW, 
				FLOW_MHV.UNADJUSTED_HRLY_VALUE AS UNADJ_FLOW, 
				-- always have the errors
				hod.ERROR_CODES
            FROM temp_hourly_errors AS hod 
				LEFT OUTER JOIN camdecmpswks.DERIVED_HRLY_VALUE dhv_HI ON ((dhv_HI.HOUR_ID = hod.HOUR_ID) AND (dhv_HI.PARAMETER_CD = 'HI'))
				LEFT OUTER JOIN camdecmpswks.MONITOR_FORMULA mf_HI ON dhv_HI.MON_FORM_ID = mf_HI.MON_FORM_ID

				LEFT OUTER JOIN camdecmpswks.DERIVED_HRLY_VALUE dhv_SO2 ON ((dhv_SO2.HOUR_ID = hod.HOUR_ID) AND (dhv_SO2.PARAMETER_CD = 'SO2'))
				LEFT OUTER JOIN camdecmpswks.MONITOR_FORMULA mf_SO2 ON dhv_SO2.MON_FORM_ID = mf_SO2.MON_FORM_ID

				LEFT OUTER JOIN camdecmpswks.DERIVED_HRLY_VALUE dhv_NOXR ON ((dhv_NOXR.HOUR_ID = hod.HOUR_ID) AND (dhv_NOXR.PARAMETER_CD = 'NOXR'))
				LEFT OUTER JOIN camdecmpswks.MONITOR_FORMULA mf_NOXR ON dhv_NOXR.MON_FORM_ID = mf_NOXR.MON_FORM_ID

				LEFT OUTER JOIN camdecmpswks.DERIVED_HRLY_VALUE dhv_NOX ON ((dhv_NOX.HOUR_ID = hod.HOUR_ID) AND (dhv_NOX.PARAMETER_CD = 'NOX'))
				LEFT OUTER JOIN camdecmpswks.MONITOR_FORMULA mf_NOX ON dhv_NOX.MON_FORM_ID = mf_NOX.MON_FORM_ID

				LEFT OUTER JOIN camdecmpswks.DERIVED_HRLY_VALUE dhv_CO2 ON ((dhv_CO2.HOUR_ID = hod.HOUR_ID) AND (dhv_CO2.PARAMETER_CD = 'CO2'))
				LEFT OUTER JOIN camdecmpswks.MONITOR_FORMULA mf_CO2 ON dhv_CO2.MON_FORM_ID = mf_CO2.MON_FORM_ID
				
				LEFT OUTER JOIN camdecmpswks.MONITOR_HRLY_VALUE AS FLOW_MHV ON ((HOD.HOUR_ID = FLOW_MHV.HOUR_ID) AND (FLOW_MHV.PARAMETER_CD = 'FLOW'))
                -- make sure we have at least 1 record, since we are doing LEFT OUTER JOINs on DHV		
            WHERE hod.HOUR_ID in (SELECT HOUR_ID FROM camdecmpswks.DERIVED_HRLY_VALUE WHERE PARAMETER_CD in ('HI', 'SO2', 'NOXR', 'NOX', 'CO2') )
            OR hod.HOUR_ID in (SELECT HOUR_ID FROM camdecmpswks.MONITOR_HRLY_VALUE WHERE PARAMETER_CD = 'FLOW' );

END;
$BODY$;
