CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_noxappemixedfuel(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_NOXAPPEMIXEDFUEL

    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_NOXAPPEMIXEDFUEL(
    SELECT  HOD.MON_PLAN_ID, 
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpswks.EMISSION_EVALUATION ems
                        join camdecmpswks.CHECK_LOG chl
                          on chl.chk_session_id = ems.chk_session_id
                         and chl.mon_loc_id = hod.mon_loc_id
                         and ( chl.op_begin_date < hod.begin_date or ( chl.op_begin_date = hod.begin_date and chl.op_begin_hour <= hod.begin_hour ) )
                         and ( chl.op_end_date > hod.begin_date or ( chl.op_end_date = hod.begin_date and chl.op_end_hour >= hod.begin_hour ) )
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.severity_cd = chl.severity_cd
                 where  ems.rpt_period_id = hod.rpt_period_id
                   and  ems.mon_plan_id = hod.mon_plan_id
            ) as error_codes
                select  hod.hour_id,
                        mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD
                  from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                        join camdecmpswks.HRLY_OP_DATA hod 
                          on hod.rpt_period_id = vRptPeriodId
                         and hod.mon_loc_id = mpl.mon_loc_id
                 where  mpl.mon_plan_id = vmonplanid
            ) as HOD 
             AND DHV_NOXR.MON_LOC_ID = HOD.MON_LOC_ID
             AND DHV_NOXR.HOUR_ID = HOD.HOUR_ID
            LEFT JOIN camdecmpswks.DERIVED_HRLY_VALUE dhv_HI
              ON dhv_HI.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
             AND dhv_HI.MON_LOC_ID = hod.MON_LOC_ID
             AND dhv_HI.HOUR_ID = hod.HOUR_ID
             AND dhv_HI.PARAMETER_CD = 'HI'
            LEFT JOIN camdecmpswks.DERIVED_HRLY_VALUE dhv_NOX
              ON dhv_NOX.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
             AND dhv_NOX.MON_LOC_ID = hod.MON_LOC_ID
             AND dhv_NOX.HOUR_ID = hod.HOUR_ID
             AND dhv_NOX.PARAMETER_CD = 'NOX'
  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXAPPEMIXEDFUEL');
END
$procedure$