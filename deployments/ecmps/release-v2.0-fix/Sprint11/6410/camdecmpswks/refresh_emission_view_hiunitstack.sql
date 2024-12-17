CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_hiunitstack
(
    IN vmonplanid character varying,
    IN vrptperiodid numeric
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE 
BEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_HIUNITSTACK	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_HIUNITSTACK(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		LOAD_RANGE,
		COMMON_STACK_LOAD_RANGE,
		HI_FORMULA_CD,
		RPT_HI_RATE,
		CALC_HI_RATE,
		ERROR_CODES
	)
    select  mpl.MON_PLAN_ID, 
            hod.MON_LOC_ID, 
            hod.RPT_PERIOD_ID,
            camdecmpswks.format_date_hour( hod.BEGIN_DATE, hod.BEGIN_HOUR, null ) as DATE_HOUR,
            hod.OP_TIME,
            hod.HR_LOAD as UNIT_LOAD,
            hod.LOAD_UOM_CD as LOAD_UOM,
            hod.LOAD_RANGE, 
            hod.COMMON_STACK_LOAD_RANGE,
            frm.EQUATION_CD as HI_FORMULA_CODE,
            dhv.ADJUSTED_HRLY_VALUE as RPT_HI_RATE,
            dhv.CALC_ADJUSTED_HRLY_VALUE as CALC_HI_RATE, 
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpswks.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = ems.CHK_SESSION_ID
                   and  chl.MON_LOC_ID = hod.MON_LOC_ID
                   and  ( chl.OP_BEGIN_DATE < hod.BEGIN_DATE or ( chl.OP_BEGIN_DATE = hod.BEGIN_DATE and chl.OP_BEGIN_HOUR <= hod.BEGIN_HOUR ) )
                   and  ( chl.OP_END_DATE > hod.BEGIN_DATE or ( chl.OP_END_DATE = hod.BEGIN_DATE and chl.OP_END_HOUR >= hod.BEGIN_HOUR ) )
            ) as ERROR_CODES
      from  (
                select  vmonplanid as MON_PLAN_ID,
                        vrptperiodid as RPT_PERIOD_ID
            ) sel
            join camdecmpswks.MONITOR_PLAN_LOCATION mpl
              on mpl.MON_PLAN_ID = sel.MON_PLAN_ID
            join camdecmpswks.EMISSION_EVALUATION ems
              on ems.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
             and ems.MON_PLAN_ID = mpl.MON_PLAN_ID
            join camdecmpswks.HRLY_OP_DATA hod 
              on hod.rpt_period_id = ems.rpt_period_id
             and hod.mon_loc_id = mpl.mon_loc_id
            join camdecmpswks.DERIVED_HRLY_VALUE dhv
              on dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
             and dhv.MON_LOC_ID = hod.MON_LOC_ID
             and dhv.HOUR_ID = hod.HOUR_ID
             and dhv.PARAMETER_CD = 'HI'
            left join camdecmpswks.MONITOR_FORMULA frm
              on frm.MON_FORM_ID = dhv.MON_FORM_ID
     where  not exists
            (
                select  1
                  from  camdecmpswks.MONITOR_HRLY_VALUE mhv
                 where  mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                   and  mhv.MON_LOC_ID = hod.MON_LOC_ID
                   and  mhv.HOUR_ID = hod.HOUR_ID
                   and  mhv.PARAMETER_CD = 'FLOW'
            );


    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'HIUNITSTACK');
END
$procedure$
