CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_dailycal
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    RAISE NOTICE 'Deleting existing records...';

    DELETE FROM camdecmpswks.EMISSION_VIEW_DAILYCAL
    WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;


    RAISE NOTICE 'Refreshing view data...';

    INSERT 
      INTO  camdecmpswks.EMISSION_VIEW_DAILYCAL
            (
                MON_PLAN_ID,
                MON_LOC_ID,
                RPT_PERIOD_ID,
                TEST_SUM_ID,
                COMPONENT_IDENTIFIER,
                COMPONENT_TYPE_CD,
                SPAN_SCALE_CD,
                END_DATETIME,
                RPT_TEST_RESULT_CD,
                CALC_TEST_RESULT_CD,
                APPLICABLE_SPAN_VALUE,
                UPSCALE_GAS_LEVEL_CD,
                UPSCALE_INJECTION_DATE,
                UPSCALE_INJECTION_TIME,
                UPSCALE_MEASURED_VALUE,
                UPSCALE_REF_VALUE,
                RPT_UPSCALE_CE_OR_MEAN_DIFF,
                RPT_UPSCALE_APS_IND,
                CALC_UPSCALE_CE_OR_MEAN_DIFF,
                CALC_UPSCALE_APS_IND,
                ZERO_INJECTION_DATE,
                ZERO_INJECTION_TIME,
                ZERO_MEASURED_VALUE,
                ZERO_REF_VALUE,
                RPT_ZERO_CE_OR_MEAN_DIFF,
                RPT_ZERO_APS_IND,
                CALC_ZERO_CE_OR_MEAN_DIFF,
                CALC_ZERO_APS_IND,
                RPT_ONLINE_OFFLINE_IND,
                CALC_ONLINE_OFFLINE_IND,
                UPSCALE_GAS_TYPE_CD,
                VENDOR_ID,
                CYLINDER_ID,
                EXPIRATION_DATE,
                ERROR_CODES
            )
    select  mpl.MON_PLAN_ID, 
            dts.MON_LOC_ID, 
            dts.RPT_PERIOD_ID,
            dts.DAILY_TEST_SUM_ID,
            cmp.COMPONENT_IDENTIFIER,
            cmp.COMPONENT_TYPE_CD,
            dts.SPAN_SCALE_CD,
            camdecmpswks.format_date_hour( dts.DAILY_TEST_DATE, dts.DAILY_TEST_HOUR, dts.DAILY_TEST_MIN ) as END_DATETIME,
            dts.TEST_RESULT_CD as RPT_TEST_RESULT_CD,
            dts.CALC_TEST_RESULT_CD as CALC_TEST_RESULT_CD,
            spn.SPAN_VALUE as APPLICABLE_SPAN_VALUE,
            dcl.UPSCALE_GAS_LEVEL_CD,
            dcl.UPSCALE_INJECTION_DATE,
            camdecmpswks.format_time( dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN ) as UPSCALE_INJECTION_TIME,
            dcl.UPSCALE_MEASURED_VALUE,
            dcl.UPSCALE_REF_VALUE,
            dcl.UPSCALE_CAL_ERROR as RPT_UPSCALE_CE_OR_MEAN_DIFF,
            dcl.UPSCALE_APS_IND as RPT_UPSCALE_APS_IND,
            dcl.CALC_UPSCALE_CAL_ERROR as CALC_UPSCALE_CE_OR_MEAN_DIFF,
            dcl.CALC_UPSCALE_APS_IND,
            dcl.ZERO_INJECTION_DATE,
            camdecmpswks.format_time( dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN ) as ZERO_INJECTION_TIME,
            dcl.ZERO_MEASURED_VALUE,
            dcl.ZERO_REF_VALUE,
            dcl.ZERO_CAL_ERROR as RPT_ZERO_CE_OR_MEAN_DIFF,
            dcl.ZERO_APS_IND as RPT_ZERO_APS_IND,
            dcl.CALC_ZERO_CAL_ERROR as CALC_ZERO_CE_OR_MEAN_DIFF,
            dcl.CALC_ZERO_APS_IND,
            dcl.ONLINE_OFFLINE_IND as RPT_ONLINE_OFFLINE_IND,
            dcl.CALC_ONLINE_OFFLINE_IND,
            dcl.UPSCALE_GAS_TYPE_CD,
            dcl.VENDOR_ID,
            dcl.CYLINDER_IDENTIFIER,
            dcl.EXPIRATION_DATE,
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
             and dts.TEST_TYPE_CD = 'DAYCAL'
            join camdecmpswks.DAILY_CALIBRATION as dcl
              on dcl.RPT_PERIOD_ID = dts.RPT_PERIOD_ID
             and dcl.DAILY_TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
            left join camdecmpswks.COMPONENT AS cmp
              on cmp.COMPONENT_ID = dts.COMPONENT_ID
            left join camdecmpswks.MONITOR_SPAN as spn
              on spn.MON_LOC_ID = dts.MON_LOC_ID
             and spn.COMPONENT_TYPE_CD = cmp.COMPONENT_TYPE_CD
             and coalesce( spn.SPAN_SCALE_CD, '' ) = coalesce( dts.SPAN_SCALE_CD, '' )
             and camdecmpswks.EMISSIONS_MONITOR_SPAN_ACTIVE( spn.BEGIN_DATE, spn.BEGIN_HOUR, spn.END_DATE, spn.END_HOUR, dts.DAILY_TEST_DATE, dts.DAILY_TEST_HOUR ) = 1;

    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'DAILYCAL');
END
$procedure$
