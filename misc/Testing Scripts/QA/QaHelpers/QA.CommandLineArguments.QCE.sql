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
  from  TEST_SUMMARY tst 
        join MONITOR_LOCATION loc on loc.MON_LOC_ID = tst.MON_LOC_ID
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
 --where  tst.TEST_TYPE_CD = 'RATA'
 order
    by  ORIS_CODE,
        LOCATIONS

use ECMPS
go

-- QA Evaluation Information
select  fac.ORIS_CODE,
        fac.FACILITY_NAME,
        isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME,
        tst.TEST_TYPE_CD,
        tst.TEST_NUM,
        concat( '"QAT" "', pln.MON_PLAN_ID, '" "', tst.TEST_SUM_ID, '"' ) as COMMAND_LINE_ARGS
        --, tst.TEST_SUM_ID
        --, pln.MON_PLAN_ID
        --, pln.END_RPT_PERIOD_ID
  from  TEST_SUMMARY tst 
        join MONITOR_LOCATION loc on loc.MON_LOC_ID = tst.MON_LOC_ID
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
 --where  tst.TEST_TYPE_CD = 'RATA'
 --where  isnull( unt.UNITID, stp.STACK_NAME ) in ( '4', '5', 'GT1' )
 order
    by  ORIS_CODE,
        LOCATION_NAME,
        tst.TEST_TYPE_CD,
        tst.TEST_NUM
