use ECMPS
go

-- MP Evaluation Information
select  distinct
        fac.ORIS_CODE,
        fac.FACILITY_NAME,
        dbo.ConcatMonitorPlanLocations( pln.MON_PLAN_ID ) as LOCATIONS,
        pln.MON_PLAN_ID,
        concat( '"MP" "', pln.MON_PLAN_ID, '"' ) as COMMAND_LINE_ARGS
        --, tst.TEST_SUM_ID
        --, pln.MON_PLAN_ID
        --, pln.END_RPT_PERIOD_ID
  from  TEST_EXTENSION_EXEMPTION tee 
        join MONITOR_LOCATION loc on loc.MON_LOC_ID = tee.MON_LOC_ID
        left join UNIT unt on unt.UNIT_ID = loc.UNIT_ID
        left join STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
        join FACILITY fac on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
        join MONITOR_PLAN_LOCATION mpl on mpl.MON_LOC_ID = loc.MON_LOC_ID
        join MONITOR_PLAN pln 
          on pln.MON_PLAN_ID = mpl.MON_PLAN_ID
         and isnull( pln.END_RPT_PERIOD_ID, 999 ) in 
             ( 
                select  max( isnull( ex2.END_RPT_PERIOD_ID, 999 ) ) 
                  from  MONITOR_PLAN_LOCATION ex1
                        join MONITOR_PLAN ex2 on ex2.MON_PLAN_ID = ex1.MON_PLAN_ID
                where ex1.MON_LOC_ID = loc.MON_LOC_ID
             )
 where  isnull( unt.UNITID, stp.STACK_NAME ) in ( '1', '2', 'CS0AAN' )
   and  exists
        (
            select  1
              from  CHECK_SESSION chs
             where  chs.CHK_SESSION_ID = tee.CHK_SESSION_ID
        )
 order
    by  ORIS_CODE,
        LOCATIONS

use ECMPS
go

-- QA Evaluation Information
select  fac.ORIS_CODE,
        fac.FACILITY_NAME,
        isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME,
        prd.PERIOD_ABBREVIATION as QUARTER,
        tee.EXTENS_EXEMPT_CD,
        case
            when sys.SYSTEM_IDENTIFIER is not null then
                concat( sys.SYSTEM_IDENTIFIER, ' (', sys.SYS_TYPE_CD, ')' )
        end as SYSTEM_INFORMATION,
        case
            when cmp.COMPONENT_IDENTIFIER is not null then
                concat( cmp.COMPONENT_IDENTIFIER, ' (', cmp.COMPONENT_TYPE_CD, ')' )
        end as COMPONENT_INFORMATION,
        concat( '"TEE" "', pln.MON_PLAN_ID, '" "', tee.TEST_EXTENSION_EXEMPTION_ID, '"' ) as COMMAND_LINE_ARGS
        --, tst.TEST_SUM_ID
        --, pln.MON_PLAN_ID
        --, pln.END_RPT_PERIOD_ID
  from  TEST_EXTENSION_EXEMPTION tee 
        join REPORTING_PERIOD prd on prd.RPT_PERIOD_ID = tee.RPT_PERIOD_ID
        join MONITOR_LOCATION loc on loc.MON_LOC_ID = tee.MON_LOC_ID
        left join UNIT unt on unt.UNIT_ID = loc.UNIT_ID
        left join STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
        join FACILITY fac on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
        join MONITOR_PLAN_LOCATION mpl on mpl.MON_LOC_ID = loc.MON_LOC_ID
        join MONITOR_PLAN pln 
          on pln.MON_PLAN_ID = mpl.MON_PLAN_ID
         and isnull( pln.END_RPT_PERIOD_ID, 999 ) in 
             ( 
                select  max( isnull( ex2.END_RPT_PERIOD_ID, 999 ) ) 
                  from  MONITOR_PLAN_LOCATION ex1
                        join MONITOR_PLAN ex2 on ex2.MON_PLAN_ID = ex1.MON_PLAN_ID
                where ex1.MON_LOC_ID = loc.MON_LOC_ID
             )
        left join MONITOR_SYSTEM sys on sys.MON_SYS_ID = tee.MON_SYS_ID
        left join COMPONENT cmp on cmp.COMPONENT_ID = tee.COMPONENT_ID
 where  isnull( unt.UNITID, stp.STACK_NAME ) in ( '1', '2', 'CS0AAN' )
   and  exists
        (
            select  1
              from  CHECK_SESSION chs
             where  chs.CHK_SESSION_ID = tee.CHK_SESSION_ID
        )
 order
    by  ORIS_CODE,
        LOCATION_NAME,
        QUARTER,
        EXTENS_EXEMPT_CD,
        sys.SYSTEM_IDENTIFIER,
        cmp.COMPONENT_IDENTIFIER

