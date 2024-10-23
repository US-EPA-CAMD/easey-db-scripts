CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_otherdaily
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    RAISE NOTICE 'Deleting existing records...';

	DELETE FROM camdecmpswks.EMISSION_VIEW_OTHERDAILY 	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;
    RAISE NOTICE 'Refreshing view data...';

	INSERT INTO camdecmpswks.EMISSION_VIEW_OTHERDAILY    (
        MON_PLAN_ID,
        MON_LOC_ID,
        RPT_PERIOD_ID,
        TEST_TYPE_CD,
        SYSTEM_COMPONENT_IDENTIFIER,
        SYSTEM_COMPONENT_TYPE,
        SPAN_SCALE_CD,
        DATE_HOUR,
        RPT_TEST_RESULT,
        CALC_TEST_RESULT_CD,
        TEST_SUM_ID,
        ERROR_CODES
    )    select  sel.MON_PLAN_ID, 
            dts.MON_LOC_ID, 
            sel.RPT_PERIOD_ID,
            dts.TEST_TYPE_CD,
            coalesce( sys.SYSTEM_IDENTIFIER, cmp.COMPONENT_IDENTIFIER ) as SYSTEM_COMPONENT_IDENTIFIER,
            coalesce( sys.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD ) AS SYSTEM_COMPONENT_TYPE,
            dts.SPAN_SCALE_CD,
            ( dts.DAILY_TEST_DATE || ' ' || camdecmpswks.format_time( dts.DAILY_TEST_HOUR, dts.DAILY_TEST_MIN ) ) as DATE_HOUR,
            dts.TEST_RESULT_CD AS RPT_TEST_RESULT_CD,
            dts.CALC_TEST_RESULT_CD,
            dts.DAILY_TEST_SUM_ID,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpswks.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = ems.CHK_SESSION_ID
                   and  chl.TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
            ) as ERROR_CODES
      from  (
                select  vmonplanid as MON_PLAN_ID,
                        vrptperiodid as RPT_PERIOD_ID
            ) sel
            join camdecmpswks.EMISSION_EVALUATION ems
              on ems.MON_PLAN_ID = sel.MON_PLAN_ID
             and ems.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            join camdecmpswks.MONITOR_PLAN_LOCATION mpl
              on mpl.MON_PLAN_ID = sel.MON_PLAN_ID
            join camdecmpswks.DAILY_TEST_SUMMARY as dts
              on dts.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
             and dts.MON_LOC_ID = mpl.MON_LOC_ID
             and dts.TEST_TYPE_CD != 'DAYCAL'
            left join camdecmpswks.MONITOR_SYSTEM as sys
              on sys.MON_SYS_ID = dts.MON_SYS_ID
            left join camdecmpswks.COMPONENT as cmp
              on cmp.COMPONENT_ID = dts.COMPONENT_ID;

    RAISE NOTICE 'Refreshing view counts...';

    CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'OTHERDAILY');
END
$procedure$
