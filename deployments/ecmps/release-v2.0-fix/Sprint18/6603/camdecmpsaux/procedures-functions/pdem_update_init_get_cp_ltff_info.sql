create or replace function camdecmpsaux.PDEM_Update_Init_Get_Cp_Ltff_Info
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric
)
    returns table
            (
                Cp_Ltff smallint
            )

language plpgsql

as $function$

declare
    vReportBeginDate date;
    vReportEndDate date;
begin

    call camdecmpsaux.PDEM_Update_Init_Get_Report_Dates( vMonPlanId, vRptPeriodId, vReportBeginDate, vReportEndDate );
    
    return query
        select  max( case when loc.Stack_Pipe_Id is not null and mth.Method_Cd = 'LTFF' then 1 else 0 end )::smallint as Cp_Ltff
          from  camdecmps.MONITOR_PLAN_LOCATION mpl
                join camdecmps.MONITOR_LOCATION loc
                  on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                join camdecmps.STACK_PIPE stp
                  on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id
                join camdecmps.MONITOR_METHOD mth
                  on mth.Mon_Loc_Id = loc.Mon_Loc_Id
         where  mpl.Mon_Plan_Id = vMonPlanId
           and  vReportBeginDate <= vReportEndDate
           and  coalesce( mth.Begin_Date, vReportBeginDate ) <= vReportEndDate
           and  coalesce( mth.End_Date, vReportEndDate ) >= vReportBeginDate;

end;

$function$;
