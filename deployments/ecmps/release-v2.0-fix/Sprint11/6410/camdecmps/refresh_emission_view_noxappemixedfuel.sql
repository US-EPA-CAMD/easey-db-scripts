CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_noxappemixedfuel(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_NOXAPPEMIXEDFUEL	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_NOXAPPEMIXEDFUEL(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		SYSTEM_ID,		UNIT_LOAD,		LOAD_UOM,		CALC_HI_RATE,		OPERATING_CONDITION_CD,		SEGMENT_NUMBER,		RPT_NOX_EMISSION_RATE,		CALC_NOX_EMISSION_RATE,		NOX_MASS_RATE_FORMULA_CD,		RPT_NOX_MASS_RATE,		CALC_NOX_MASS_RATE,		ERROR_CODES	)
    SELECT  HOD.MON_PLAN_ID,             HOD.MON_LOC_ID,             HOD.RPT_PERIOD_ID,            camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),            HOD.OP_TIME,            MS_NOXR.SYSTEM_IDENTIFIER AS SYSTEM_ID,            HOD.HR_LOAD AS UNIT_LOAD,             HOD.LOAD_UOM_CD AS LOAD_UOM,             DHV_HI.ADJUSTED_HRLY_VALUE AS CALC_HI_RATE,            DHV_NOXR.OPERATING_CONDITION_CD,            DHV_NOXR.SEGMENT_NUM AS SEGMENT_NUMBER,            DHV_NOXR.ADJUSTED_HRLY_VALUE AS RPT_NOX_EMISSION_RATE,            DHV_NOXR.CALC_ADJUSTED_HRLY_VALUE AS CALC_NOX_EMISSION_RATE,            MF_NOX.EQUATION_CD AS NOX_MASS_RATE_FORMULA_CD,            DHV_NOX.ADJUSTED_HRLY_VALUE AS RPT_NOX_MASS_RATE,            DHV_NOX.CALC_ADJUSTED_HRLY_VALUE AS CALC_NOX_MASS_RATE,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmps.EMISSION_EVALUATION ems
                        join camdecmpsaux.CHECK_LOG chl
                          on chl.chk_session_id = ems.chk_session_id
                         and chl.mon_loc_id = hod.mon_loc_id
                         and ( chl.op_begin_date < hod.begin_date or ( chl.op_begin_date = hod.begin_date and chl.op_begin_hour <= hod.begin_hour ) )
                         and ( chl.op_end_date > hod.begin_date or ( chl.op_end_date = hod.begin_date and chl.op_end_hour >= hod.begin_hour ) )
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.severity_cd = chl.severity_cd
                 where  ems.rpt_period_id = hod.rpt_period_id
                   and  ems.mon_plan_id = hod.mon_plan_id
            ) as error_codes      FROM  (
                select  hod.hour_id,
                        mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD
                  from  camdecmps.MONITOR_PLAN_LOCATION mpl
                        join camdecmps.HRLY_OP_DATA hod 
                          on hod.rpt_period_id = vRptPeriodId
                         and hod.mon_loc_id = mpl.mon_loc_id
                 where  mpl.mon_plan_id = vmonplanid
            ) as HOD             JOIN camdecmps.DERIVED_HRLY_VALUE DHV_NOXR               ON DHV_NOXR.RPT_PERIOD_ID = HOD.RPT_PERIOD_ID
             AND DHV_NOXR.MON_LOC_ID = HOD.MON_LOC_ID
             AND DHV_NOXR.HOUR_ID = HOD.HOUR_ID             AND DHV_NOXR.PARAMETER_CD = 'NOXR'              AND DHV_NOXR.OPERATING_CONDITION_CD IS NOT NULL            JOIN camdecmps.MONITOR_SYSTEM MS_NOXR                ON MS_NOXR.MON_SYS_ID = DHV_NOXR.MON_SYS_ID AND MS_NOXR.SYS_TYPE_CD='NOXE'
            LEFT JOIN camdecmps.DERIVED_HRLY_VALUE dhv_HI
              ON dhv_HI.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
             AND dhv_HI.MON_LOC_ID = hod.MON_LOC_ID
             AND dhv_HI.HOUR_ID = hod.HOUR_ID
             AND dhv_HI.PARAMETER_CD = 'HI'
            LEFT JOIN camdecmps.DERIVED_HRLY_VALUE dhv_NOX
              ON dhv_NOX.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
             AND dhv_NOX.MON_LOC_ID = hod.MON_LOC_ID
             AND dhv_NOX.HOUR_ID = hod.HOUR_ID
             AND dhv_NOX.PARAMETER_CD = 'NOX'            LEFT JOIN camdecmps.MONITOR_FORMULA MF_NOX                 ON MF_NOX.MON_FORM_ID = DHV_NOX.MON_FORM_ID;
  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXAPPEMIXEDFUEL');
END
$procedure$
