CREATE OR REPLACE 
FUNCTION camdecmpswks.weekly_system_integrity_data
(
	monPlanId       character varying,
	rptPeriodId     numeric
)
    RETURNS TABLE   (
                        location_name               character varying, 
                        test_type_cd                character varying, 
                        system_identifier           character varying, 
                        sys_type_cd                 character varying, 
                        component_identifier        character varying, 
                        component_type_cd           character varying,
                        test_datetime               timestamp without time zone, 
                        span_scale_cd               character varying, 
                        test_result_cd              character varying,
                        hg_converter_ind            numeric,
                        gas_level_cd                character varying, 
                        ref_value                   numeric,
                        measured_value              numeric,
                        aps_ind                     numeric,
                        system_integrity_error      numeric,
                        test_datehour               timestamp without time zone, 
                        test_date                   date,
                        test_hour                   numeric,
                        test_min                    numeric,
                        formatted_test_date         character varying, 
                        mon_sys_id                  character varying, 
                        component_id                character varying, 
                        weekly_sys_integrity_id     character varying, 
                        weekly_test_sum_id          character varying, 
                        mon_loc_id                  character varying, 
                        mon_plan_id                 character varying, 
                        rpt_period_id               numeric
                    ) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN  
    RETURN QUERY
        select	coalesce(unt.UNITID, stp.STACK_NAME) LOCATION_NAME,
                wts.TEST_TYPE_CD,
                sys.SYSTEM_IDENTIFIER,
                sys.SYS_TYPE_CD,
                cmp.COMPONENT_IDENTIFIER,
                cmp.COMPONENT_TYPE_CD,
                date_add( 'minute', wts.TEST_MIN, date_add( 'hour', wts.TEST_HOUR, wts.TEST_DATE) ) as TEST_DATETIME,
                wts.SPAN_SCALE_CD,
                wts.TEST_RESULT_CD,
                cmp.HG_CONVERTER_IND,
                wsi.GAS_LEVEL_CD,
                wsi.REF_VALUE,
                wsi.MEASURED_VALUE,
                wsi.APS_IND,
                wsi.SYSTEM_INTEGRITY_ERROR,
                date_add( 'hour', wts.TEST_HOUR, wts.TEST_DATE) as TEST_DATEHOUR,
                wts.TEST_DATE,
                wts.TEST_HOUR,
                wts.TEST_MIN,
                case 
                    when wts.TEST_MIN is not null
                    then concat( to_char( wts.TEST_DATE, 'MM/DD/YYYY' ), ' at ',  lpad( wts.TEST_HOUR::varchar, 2, '0' ), ':',  lpad( wts.TEST_MIN::varchar, 2, '0' ) )
                    else concat( to_char( wts.TEST_DATE, 'MM/DD/YYYY' ), ' at hour ',  lpad( wts.TEST_HOUR::varchar, 2, '0' ) )
                end::varchar as FORMATTED_TEST_DATE,
                wts.MON_SYS_ID,
                wts.COMPONENT_ID,
                wsi.WEEKLY_SYS_INTEGRITY_ID,
                wts.WEEKLY_TEST_SUM_ID,
                mpl.MON_LOC_ID,
                ems.MON_PLAN_ID,
                ems.RPT_PERIOD_ID
            from	camdecmpswks.EMISSION_EVALUATION ems
                    join camdecmpsmd.REPORTING_PERIOD prd
                        on	prd.RPT_PERIOD_ID = ems.RPT_PERIOD_ID
                    join camdecmpswks.MONITOR_PLAN_LOCATION mpl
                        on	mpl.MON_PLAN_ID = ems.MON_PLAN_ID
                    join camdecmpswks.MONITOR_LOCATION loc
                        on	loc.MON_LOC_ID = mpl.MON_LOC_ID
                    left join camd.UNIT unt
                        on	unt.UNIT_ID = loc.UNIT_ID
                    left join camdecmpswks.STACK_PIPE stp
                        on	stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
                    join camdecmpswks.WEEKLY_TEST_SUMMARY wts
                        on	wts.MON_LOC_ID = mpl.MON_LOC_ID AND ems.RPT_PERIOD_ID=wts.RPT_PERIOD_ID
                    join camdecmpswks.WEEKLY_SYSTEM_INTEGRITY wsi
                        on	wsi.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
                    left join camdecmpswks.MONITOR_SYSTEM sys
                        on	sys.MON_SYS_ID = wts.MON_SYS_ID
                    left join camdecmpswks.COMPONENT cmp
                        on	cmp.COMPONENT_ID = wts.COMPONENT_ID
            where	(monPlanId is null or ems.MON_PLAN_ID = monPlanId)
                    and (rptPeriodId is null or ems.RPT_PERIOD_ID = rptPeriodId);

END;
$BODY$;