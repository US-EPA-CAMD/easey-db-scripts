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
  from  QA_CERT_EVENT qce 
        join MONITOR_LOCATION loc on loc.MON_LOC_ID = qce.MON_LOC_ID
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
 where  isnull( unt.UNITID, stp.STACK_NAME ) in ( '4', 'CS0AAN', 'GT1' )
   and  exists
        (
            select  1
              from  CHECK_SESSION chs
             where  chs.CHK_SESSION_ID = qce.CHK_SESSION_ID
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
        qce.QA_CERT_EVENT_CD,
        qce.QA_CERT_EVENT_DATE,
        qce.QA_CERT_EVENT_HOUR,
        concat( sys.SYSTEM_IDENTIFIER, ' (', sys.SYS_TYPE_CD, ')' ) as SYSTEM_INFORMATION,
        concat( cmp.COMPONENT_IDENTIFIER, ' (', cmp.COMPONENT_TYPE_CD, ')' ) as COMPONENT_INFORMATION,
        concat( '"QCE" "', pln.MON_PLAN_ID, '" "', qce.QA_CERT_EVENT_ID, '"' ) as COMMAND_LINE_ARGS
        --, tst.TEST_SUM_ID
        --, pln.MON_PLAN_ID
        --, pln.END_RPT_PERIOD_ID
  from  QA_CERT_EVENT qce 
        join MONITOR_LOCATION loc on loc.MON_LOC_ID = qce.MON_LOC_ID
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
        left join MONITOR_SYSTEM sys on sys.MON_SYS_ID = qce.MON_SYS_ID
        left join COMPONENT cmp on cmp.COMPONENT_ID = qce.COMPONENT_ID
 where  isnull( unt.UNITID, stp.STACK_NAME ) in ( '4', 'CS0AAN', 'GT1' )
   and  exists
        (
            select  1
              from  CHECK_SESSION chs
             where  chs.CHK_SESSION_ID = qce.CHK_SESSION_ID
        )
 order
    by  ORIS_CODE,
        LOCATION_NAME,
        qce.QA_CERT_EVENT_CD,
        qce.QA_CERT_EVENT_DATE,
        qce.QA_CERT_EVENT_HOUR,
        sys.SYSTEM_IDENTIFIER,
        cmp.COMPONENT_IDENTIFIER

