create or replace function camdecmpsaux.PDEM_Apportionment_Get_Table
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric
)
    returns table
            (
                Apport_Id numeric,
                Mon_Plan_Id varchar,
                Begin_Rpt_Period_Id numeric,
                End_Rpt_Period_Id numeric
            )

language plpgsql

as $function$

declare
begin

    return query
        select  app.Apport_Id,
                app.Mon_Plan_Id,
                app.Begin_Rpt_Period_Id,
                app.End_Rpt_Period_Id
          from  camdecmpsaux.APPORTIONMENT app
                join camdecmpsmd.REPORTING_PERIOD prd
                  on prd.Rpt_Period_Id = vRptPeriodId /*Replace Rpt_Period_Id*/
                join camdecmpsmd.REPORTING_PERIOD prb
                  on prb.Rpt_Period_Id = app.Begin_Rpt_Period_Id
                left join camdecmpsmd.REPORTING_PERIOD pre
                  on pre.Rpt_Period_Id = app.End_Rpt_Period_Id
          where  app.Mon_Plan_Id = vMonPlanId /*Replace Mon_Plan_Id*/
            and  prd.Begin_Date <= coalesce( pre.End_Date, prd.End_Date )
            and  prd.End_Date >= prb.Begin_Date;

end;

$function$;
