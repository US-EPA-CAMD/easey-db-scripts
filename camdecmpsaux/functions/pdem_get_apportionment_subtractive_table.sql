create or replace function camdecmpsaux.PDEM_Get_Apportionment_Subtractive_Table
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric
)
    returns table
            (
                Apport_Id numeric,
                Apport_Range_Id numeric,
                Apport_Data_Id numeric,
                Target_Tag varchar,
                Subtracting_Tag varchar,
                Pollutant_Cd varchar
            )

language plpgsql

as $function$

declare
begin

    return query
        select  app.Apport_Id,
                apr.Apport_Range_Id,
                apd.Apport_Data_Id,
                xml.Target_Tag,
                xml.Subtracting_Tag,
                xml.Pollutant_Cd
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
                join xmltable
                     (
                        'SUBTRACTIONS/SUBTRACTION'
                        passing apd.Subtractive_Xml
                        columns Target_Tag varchar      path '@TARGET_TAG',
                                Subtracting_Tag varchar path '@SUBTRACTING_TAG',
                                Pollutant_Cd varchar    path '@POLLUTANT_CD'
                     ) xml
                  on null is null
         where  app.Mon_Plan_Id = vMonPlanId /*Replace Mon_Plan_Id*/
           and  prd.Begin_Date <= coalesce( pre.End_Date, prd.End_Date )
           and  prd.End_Date >= prb.Begin_Date
         order
            by  app.Apport_Id,
                apr.Apport_Range_Id,
                apd.Apport_Data_Id,
                apd.Evaluation_Order,
                Target_Tag,
                Subtracting_Tag;

end;

$function$;
