create or replace function camdecmpsaux.PDEM_Apportionment_Get_Range_Table
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric
)
    returns table
            (
                Apport_Id numeric,
                Apport_Range_Id numeric,
                Begin_DateHour timestamp,
                End_DateHour timestamp
            )

language plpgsql

as $function$

declare
begin

    return query
        select  app.Apport_Id,
                apr.Apport_Range_Id,
                case 
                    when apr.Begin_Date is null then prd.Begin_Date::timestamp 
                    when apr.Begin_Hour is null then apr.Begin_Date::timestamp
                    else apr.Begin_Date + interval '1 hour' * apr.Begin_Hour
                end Begin_DateHour,
                case 
                    when apr.End_Date is null then prd.End_Date + interval '1 hour' * 23 
                    when apr.End_Hour is null then apr.End_Date + interval '1 hour' * 23 
                    else apr.End_Date + interval '1 hour' * apr.End_Hour
                end End_DateHour
          from  camdecmpsaux.Apportionment app
                join camdecmpsmd.REPORTING_PERIOD prd
                  on prd.Rpt_Period_Id = vRptPeriodId /*Replace Rpt_Period_Id*/
                join camdecmpsmd.REPORTING_PERIOD prb
                  on prb.Rpt_Period_Id = app.Begin_Rpt_Period_Id
                left join camdecmpsmd.REPORTING_PERIOD pre
                  on pre.Rpt_Period_Id = app.End_Rpt_Period_Id
                join camdecmpsaux.Apportionment_Range apr
                  on apr.Apport_Id = app.Apport_Id
         where  app.Mon_Plan_Id = vMonPlanId /*Replace Mon_Plan_Id*/
           and  prd.Begin_Date <= coalesce( pre.End_Date, prd.End_Date )
           and  prd.End_Date >= prb.Begin_Date
         order 
            by  Begin_DateHour,
                End_DateHour;

end;

$function$;
