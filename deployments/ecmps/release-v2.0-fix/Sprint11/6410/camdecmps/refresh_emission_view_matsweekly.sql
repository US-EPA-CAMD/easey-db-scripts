CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_matsweekly
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_MATSWEEKLY	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_MATSWEEKLY(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		WEEKLY_TEST_SUM_ID,		SYSTEM_COMPONENT_IDENTIFIER,		SYSTEM_COMPONENT_TYPE,		DATE_HOUR,		TEST_TYPE,		TEST_RESULT,		SPAN_SCALE,		GAS_LEVEL,		REF_VALUE,		MEASURED_VALUE,		SYSTEM_INTEGRITY_ERROR,		ERROR_CODES	)    select  ems.MON_PLAN_ID,
            wts.MON_LOC_ID,
            wts.RPT_PERIOD_ID,
            wts.WEEKLY_TEST_SUM_ID,
            coalesce( sys.SYSTEM_IDENTIFIER, cmp.COMPONENT_IDENTIFIER ) as SYSTEM_COMPONENT_IDENTIFIER,
            coalesce( sys.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD ) as SYSTEM_COMPONENT_TYPE,
            ( wts.TEST_DATE || ' ' || camdecmps.format_time( wts.TEST_HOUR, wts.TEST_MIN ) ) as DATE_HOUR, 
            wts.TEST_TYPE_CD,
            wts.TEST_RESULT_CD,
            wts.SPAN_SCALE_CD,
            wsi.GAS_LEVEL_CD,
            wsi.REF_VALUE,
            wsi.MEASURED_VALUE,
            wsi.SYSTEM_INTEGRITY_ERROR,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpsaux.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = ems.CHK_SESSION_ID
                   and  chl.TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
                   and  chl.MON_LOC_ID = wts.MON_LOC_ID
            ) as ERROR_CODES
      from  camdecmps.EMISSION_EVALUATION ems
            join camdecmps.MONITOR_PLAN_LOCATION mpl
              on mpl.MON_PLAN_ID = ems.MON_PLAN_ID
            join camdecmps.WEEKLY_TEST_SUMMARY wts
              on wts.RPT_PERIOD_ID = ems.RPT_PERIOD_ID
             and wts.MON_LOC_ID = mpl.MON_LOC_ID
            left join camdecmps.MONITOR_SYSTEM sys
              on sys.MON_SYS_ID = wts.MON_SYS_ID
            left join camdecmps.COMPONENT cmp
              on cmp.COMPONENT_ID = wts.COMPONENT_ID
            left join camdecmps.WEEKLY_SYSTEM_INTEGRITY wsi 
              on wsi.RPT_PERIOD_ID = wts.RPT_PERIOD_ID
             and wsi.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
             and wsi.MON_LOC_ID = wts.MON_LOC_ID
     where  ems.RPT_PERIOD_ID = vrptperiodid
       and  ems.MON_PLAN_ID = vmonplanid;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MATSWEEKLY');
END
$procedure$
