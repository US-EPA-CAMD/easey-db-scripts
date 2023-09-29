-- FUNCTION: camdecmpswks.mats_derived_hourly_value_data(character varying, numeric, character varying)

DROP FUNCTION IF EXISTS camdecmpswks.mats_derived_hourly_value_data(character varying, numeric, character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.mats_derived_hourly_value_data(
	monplanid character varying,
	rptperiodid numeric,
	parametercd character varying)
    RETURNS TABLE(location_name character varying, begin_hour numeric, begin_date date, begin_datehour timestamp without time zone, parameter_cd character varying, unadjusted_hrly_value character varying, modc_cd character varying, formula_identifier character varying, formula_parameter_cd character varying, equation_cd character varying, formula_active_ind integer, mats_dhv_id character varying, mon_plan_id character varying, rpt_period_id numeric, mon_loc_id character varying, hour_id character varying, mon_form_id character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
RETURN QUERY
SELECT  COALESCE( unt.UNITID, stp.STACK_NAME ) AS LOCATION_NAME,
		    hod.BEGIN_HOUR, hod.BEGIN_DATE,	
			camdecmpswks.format_date_time(hod.BEGIN_DATE, hod.BEGIN_HOUR,0 ) BEGIN_DATEHOUR,
		    dat.PARAMETER_CD, dat.UNADJUSTED_HRLY_VALUE, dat.MODC_CD,
		    frm.FORMULA_IDENTIFIER, frm.PARAMETER_CD AS FORMULA_PARAMETER_CD, frm.EQUATION_CD,
		    CASE
		    WHEN frm.MON_FORM_ID IS NULL THEN 0
			WHEN camdecmpswks.format_date_time(frm.BEGIN_DATE, frm.BEGIN_HOUR,0)
			    >camdecmpswks.format_date_time(hod.BEGIN_DATE, hod.BEGIN_HOUR,0) THEN 0
		    WHEN (frm.END_HOUR IS NOT NULL AND camdecmpswks.format_date_time(frm.END_DATE, frm.END_HOUR,0)
			    < camdecmpswks.format_date_time(hod.BEGIN_DATE, hod.BEGIN_HOUR,0)) THEN 0
		          ELSE 1
		    END FORMULA_ACTIVE_IND,
		    dat.MATS_DHV_ID, mpl.MON_PLAN_ID, dat.RPT_PERIOD_ID, dat.MON_LOC_ID, dat.HOUR_ID, dat.MON_FORM_ID
      FROM  ( SELECT MonPlanId MON_PLAN_ID, RptPeriodId RPT_PERIOD_ID, ParameterCd PARAMETER_CD
            ) sel
            JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl ON sel.MON_PLAN_ID IS NULL OR mpl.MON_PLAN_ID = sel.MON_PLAN_ID
            JOIN camdecmpswks.MONITOR_LOCATION loc ON loc.MON_LOC_ID = mpl.MON_LOC_ID
            LEFT JOIN camd.UNIT unt     ON unt.UNIT_ID = loc.UNIT_ID
            LEFT JOIN camdecmpswks.STACK_PIPE stp    ON stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
            JOIN camd.PLANT fac     ON fac.FAC_ID IN (unt.FAC_ID, stp.FAC_ID)
			JOIN camdecmpsmd.REPORTING_PERIOD prd    ON sel.RPT_PERIOD_ID IS NULL OR prd.RPT_PERIOD_ID = sel.RPT_PERIOD_ID 
            JOIN camdecmpswks.MATS_DERIVED_HRLY_VALUE dat    ON dat.MON_LOC_ID = mpl.MON_LOC_ID 
               AND dat.RPT_PERIOD_ID = prd.RPT_PERIOD_ID 
               AND (sel.PARAMETER_CD IS NULL OR dat.PARAMETER_CD IN (sel.PARAMETER_CD || 'RE', sel.PARAMETER_CD || 'RH'))
            JOIN camdecmpswks.HRLY_OP_DATA hod   ON hod.HOUR_ID = dat.HOUR_ID
            LEFT JOIN camdecmpswks.MONITOR_FORMULA frm   ON frm.MON_FORM_ID = dat.MON_FORM_ID;
END;
$BODY$;
