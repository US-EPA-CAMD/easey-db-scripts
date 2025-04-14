create or replace function camdecmpsaux.PDEM_Update_Init_Get_Spanning_Link_Counts
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric
)
    returns table
            (
                Cs integer,
                Ms integer,
                Cp integer,
                Mp integer
            )

language plpgsql

as $function$

declare
    vReportBeginDate date;
    vReportEndDate date;
begin

    call camdecmpsaux.PDEM_Update_Init_Get_Report_Dates( vMonPlanId, vRptPeriodId, vReportBeginDate, vReportEndDate );
    
    return query
        select  sum( case when lst.Stack_Name like 'CS%' then 1 else 0 end )::integer as Cs,
                sum( case when lst.Stack_Name like 'MS%' then 1 else 0 end )::integer as Ms,
                sum( case when lst.Stack_Name like 'CP%' then 1 else 0 end )::integer as Cp,
                sum( case when lst.Stack_Name like 'MP%' then 1 else 0 end )::integer as Mp
          from  (
                    select  distinct
                            cmb.Mon_Plan_Id,
                            cmb.Unit_Id,
                            cmb.Stack_Pipe_Id,
                            cmb.Stack_Name
                      from  (
                                select  distinct
                                        pln.Mon_Plan_Id,
                                        fac.Oris_Code,
                                        unt.Unitid,
                                        stp.Stack_Name,
                                        usc.Unit_Id,
                                        usc.Stack_Pipe_Id,
                                        usc.Begin_Date,
                                        usc.End_Date
                                  from  camdecmps.UNIT_STACK_CONFIGURATION usc
                                        join camd.UNIT unt
                                          on unt.Unit_Id = usc.Unit_Id
                                        join camdecmps.STACK_PIPE stp
                                          on stp.Stack_Pipe_Id = usc.Stack_Pipe_Id
                                        join camd.PLANT fac
                                          on fac.Fac_Id in ( unt.Fac_Id, stp.Fac_Id )
                                        join camdecmps.MONITOR_LOCATION ulc
                                          on ulc.Unit_Id = usc.Unit_Id
                                        join camdecmps.MONITOR_PLAN_LOCATION upl
                                          on upl.Mon_Loc_Id = ulc.Mon_Loc_Id
                                        join camdecmps.MONITOR_LOCATION slc
                                          on slc.Stack_Pipe_Id = usc.Stack_Pipe_Id
                                        join camdecmps.MONITOR_PLAN_LOCATION spl
                                          on spl.Mon_Loc_Id = slc.Mon_Loc_Id
                                        join camdecmps.MONITOR_PLAN pln
                                          on pln.Mon_Plan_Id = upl.Mon_Plan_Id
                                         and pln.Mon_Plan_Id = spl.Mon_Plan_Id
                                 where  pln.Mon_Plan_Id = vMonPlanId
                            ) cmb
                     where  vReportBeginDate <= vReportEndDate
                       and  coalesce( cmb.Begin_Date, vReportBeginDate ) <= vReportBeginDate
                       and  coalesce( cmb.End_Date, vReportEndDate ) >= vReportEndDate
                ) lst;

end;

$function$;
