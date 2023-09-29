-- FUNCTION: camdecmpswks.mats_monitor_hourly_value_data(character varying, numeric, character varying)

DROP FUNCTION IF EXISTS camdecmpswks.mats_monitor_hourly_value_data(character varying, numeric, character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.mats_monitor_hourly_value_data(
	monplanid character varying,
	rptperiodid numeric,
	parametercd character varying)
    RETURNS TABLE(location_name character varying, begin_hour numeric, begin_date date, begin_datehour timestamp without time zone, parameter_cd character varying, unadjusted_hrly_value character varying, modc_cd character varying, pct_available numeric, mats_mhv_id character varying, mon_plan_id character varying, rpt_period_id numeric, mon_loc_id character varying, hour_id character varying, mon_sys_id character varying, system_identifier character varying, sys_type_cd character varying, sys_designation_cd character varying, component_id character varying, component_type_cd character varying, component_identifier character varying, serial_number character varying, acq_cd character varying, hg_converter_ind numeric, component_begin_date date, component_begin_datehour timestamp without time zone) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
 RETURN QUERY
SELECT  COALESCE( unt.UNITID, stp.STACK_NAME ) LOCATION_NAME,
            hod.BEGIN_HOUR, hod.BEGIN_DATE,
            camdecmpswks.format_date_time(hod.begin_date, hod.begin_hour, 0::numeric) AS begin_datehour,
            dat.PARAMETER_CD,
            dat.UNADJUSTED_HRLY_VALUE,
            dat.MODC_CD,
            dat.PCT_AVAILABLE,
            dat.MATS_MHV_ID,
            mpl.MON_PLAN_ID,
            dat.RPT_PERIOD_ID,
            dat.MON_LOC_ID,
            dat.HOUR_ID,
            dat.MON_SYS_ID,
            sys.SYSTEM_IDENTIFIER, 
            sys.SYS_TYPE_CD,
            sys.SYS_DESIGNATION_CD, 
            dat.COMPONENT_ID,
            cmp.COMPONENT_TYPE_CD,
            cmp.COMPONENT_IDENTIFIER, 
            cmp.SERIAL_NUMBER,
            cmp.ACQ_CD,
            cmp.HG_CONVERTER_IND,
            cdt.COMPONENT_BEGIN_DATE,
            cdt.COMPONENT_BEGIN_DATEHOUR	  
	  FROM  ( SELECT MonPlanId MON_PLAN_ID, RptPeriodId RPT_PERIOD_ID, ParameterCd PARAMETER_CD
            ) sel
         JOIN  camdecmpswks.MONITOR_PLAN_LOCATION mpl ON sel.MON_PLAN_ID IS NULL OR mpl.MON_PLAN_ID = sel.MON_PLAN_ID
         JOIN  camdecmpswks.MONITOR_LOCATION loc ON loc.MON_LOC_ID = mpl.MON_LOC_ID
         LEFT JOIN camd.UNIT unt ON unt.UNIT_ID = loc.UNIT_ID 
         LEFT JOIN  camdecmpswks.STACK_PIPE stp    ON stp.STACK_PIPE_ID = loc.STACK_PIPE_ID		 
         JOIN camd.plant fac   ON fac.FAC_ID IN (unt.FAC_ID, stp.FAC_ID)
         JOIN  camdecmpsmd.REPORTING_PERIOD prd  ON sel.RPT_PERIOD_ID IS NULL OR prd.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
         JOIN  camdecmpswks.MATS_MONITOR_HRLY_VALUE dat  ON dat.MON_LOC_ID = mpl.MON_LOC_ID 
             AND dat.RPT_PERIOD_ID = prd.RPT_PERIOD_ID 
             AND (sel.PARAMETER_CD IS NULL OR dat.PARAMETER_CD = sel.PARAMETER_CD || 'C')
         JOIN  camdecmpswks.HRLY_OP_DATA hod ON hod.HOUR_ID = dat.HOUR_ID
         LEFT JOIN  camdecmpswks.COMPONENT cmp ON dat.COMPONENT_ID = cmp.COMPONENT_ID
         LEFT JOIN  camdecmpswks.MONITOR_SYSTEM sys   ON dat.MON_SYS_ID = sys.MON_SYS_ID 
		   AND camdecmpswks.format_date_time(sys.BEGIN_DATE, sys.BEGIN_HOUR,0)
		        <= camdecmpswks.format_date_time(hod.BEGIN_DATE, hod.BEGIN_HOUR,0)
           AND (sys.END_HOUR IS NULL OR 
					  camdecmpswks.format_date_time(sys.END_DATE, sys.END_HOUR,0)
	            >= camdecmpswks.format_date_time(hod.BEGIN_DATE, hod.BEGIN_HOUR,0))
         LEFT JOIN ( SELECT  msc.COMPONENT_ID, MIN(msc.BEGIN_DATE) COMPONENT_BEGIN_DATE,
                       MIN(camdecmpswks.format_date_time(msc.BEGIN_DATE, msc.BEGIN_HOUR,0)) COMPONENT_BEGIN_DATEHOUR
                     FROM  camdecmpswks.MONITOR_SYSTEM_COMPONENT msc
                         GROUP BY msc.COMPONENT_ID
                      ) cdt
              ON cdt.COMPONENT_ID = dat.COMPONENT_ID;
END;
$BODY$;
