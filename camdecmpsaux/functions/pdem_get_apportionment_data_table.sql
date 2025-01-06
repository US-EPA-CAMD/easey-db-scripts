create or replace function camdecmpsaux.PDEM_Get_Apportionment_Data_Table
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric
)
    returns table
            (
                Apport_Id numeric,
                Apport_Range_Id numeric,
                Apport_Data_Id numeric,
                Evaluation_Order numeric
            )

language plpgsql

as $function$

declare
begin

    return query
        select  app.Apport_Id,
                apr.Apport_Range_Id,
                apd.Apport_Data_Id,
                apd.Evaluation_Order
          from  camdecmpsaux.Apportionment app
                join camdecmpsmd.REPORTING_PERIOD prd
                  on prd.Rpt_Period_Id = vRptPeriodId /*Replace Rpt_Period_Id*/
                join camdecmpsmd.REPORTING_PERIOD prb
                  on prb.Rpt_Period_Id = app.Begin_Rpt_Period_Id
                left join camdecmpsmd.REPORTING_PERIOD pre
                  on pre.Rpt_Period_Id = app.End_Rpt_Period_Id
                join camdecmpsaux.Apportionment_Range apr
                  on apr.Apport_Id = app.Apport_Id
                join camdecmpsaux.Apportionment_Data apd
                  on apd.Apport_Range_Id = apr.Apport_Range_Id
         where  app.Mon_Plan_Id = vMonPlanId /*Replace Mon_Plan_Id*/
           and  prd.Begin_Date <= coalesce( pre.End_Date, prd.End_Date )
           and  prd.End_Date >= prb.Begin_Date
         group  
            by  app.Apport_Id,
                apr.Apport_Range_Id,
                apd.Apport_Data_Id,
                apd.Evaluation_Order
         order  
            by  app.Apport_Id,
                apr.Apport_Range_Id,
                apd.Apport_Data_Id,
                apd.Evaluation_Order;

end;

$function$;
