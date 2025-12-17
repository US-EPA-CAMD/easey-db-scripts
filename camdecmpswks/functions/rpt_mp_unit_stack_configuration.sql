-- FUNCTION: camdecmpswks.rpt_mp_unit_stack_configuration(character varying)

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_unit_stack_configuration
(
	monplanid character varying
)
RETURNS TABLE
(
    "stackPipeIdentifier" text,
    "unitIdentifier" text,
    "beginDate" text,
    "endDate" text
) 
LANGUAGE 'sql'

COST 100
VOLATILE 
ROWS 1000
AS $BODY$

    select  stp.stack_name as "stackPipeIdentifier",
            unt.unitid as "unitIdentifier",
            camdecmpswks.format_date_hour( usc.begin_date, null, null ) as "beginDate",
            camdecmpswks.format_date_hour( usc.end_date, null, null )  as "endDate"
      from  camdecmpswks.MONITOR_PLAN pln
            join camdecmpsmd.REPORTING_PERIOD prb on prb.rpt_period_id = pln.begin_rpt_period_id
            left join camdecmpsmd.REPORTING_PERIOD pre on pre.rpt_period_id = pln.end_rpt_period_id
            join camdecmpswks.UNIT_STACK_CONFIGURATION usc
              on exists
                 (
                    select  1
                      from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                            join camdecmpswks.MONITOR_LOCATION loc using ( mon_loc_id )
                     where  mpl.mon_plan_id = pln.mon_plan_id
                       and  loc.unit_id = usc.unit_id
                 )
             and exists
                 (
                    select  1
                      from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                            join camdecmpswks.MONITOR_LOCATION loc using ( mon_loc_id )
                     where  mpl.mon_plan_id = pln.mon_plan_id
                       and  loc.stack_pipe_id = usc.stack_pipe_id
                 )
             and usc.begin_date <= coalesce( pre.end_date, usc.begin_date )
             and coalesce( usc.end_date, prb.begin_date ) >= prb.begin_date
            join camdecmpswks.STACK_PIPE stp using ( stack_pipe_id )
            join camdecmpswks.UNIT unt using ( unit_id )
     where  pln.mon_plan_id = monplanid
     order  
        by  pln.mon_plan_id,
            stp.stack_name,
            unt.unitid;

$BODY$;
