create or replace function camdecmpsaux.PDEM_Update_Init_Get_Reporting_Period_Info
(
    in vRptPeriodId numeric
)
    returns table
            (
                Calendar_Year numeric,
                Quarter numeric,
                Begin_Date date,
                End_Date date
            )

language plpgsql

as $function$

declare
begin

    return query
        select  prd.Calendar_Year,
                prd.Quarter,
                prd.Begin_Date,
                prd.End_Date
          from  camdecmpsmd.REPORTING_PERIOD prd
         where  prd.Rpt_Period_Id = vRptPeriodId;

end;

$function$;
