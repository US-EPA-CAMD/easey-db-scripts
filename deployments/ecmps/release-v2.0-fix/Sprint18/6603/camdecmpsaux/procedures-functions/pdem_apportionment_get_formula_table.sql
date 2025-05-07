create or replace function camdecmpsaux.PDEM_Apportionment_Get_Formula_Table
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric
)
    returns table
            (
                Apport_Id numeric,
                Apport_Range_Id numeric,
                Apport_Data_Id numeric,
                Monitor_Tag varchar,
                Unit_Tag varchar,
                Pollutant_Cd varchar,
                Hi_Load_Formula varchar,
                Op_Time_Formula varchar
            )

language plpgsql

as $function$

declare
begin

    return query
        select  app.Apport_Id,
                apr.Apport_Range_Id,
                apd.Apport_Data_Id,
                xml.Monitor_Tag,
                xml.Unit_Tag,
                xml.Pollutant_Cd,
                xml.Hi_Load_Formula,
                xml.Op_Time_Formula
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
                        'FORMULAE/FORMULA'
                        passing apd.Formulae_Xml
                        columns Monitor_Tag varchar         path '@MONITOR_TAG',
                                Unit_Tag varchar            path '@UNIT_TAG',
                                Pollutant_Cd varchar        path 'POLLUTANT_CD',
                                Hi_Load_Formula varchar     path 'HI_LOAD_FORMULA',
                                Op_Time_Formula varchar     path 'OP_TIME_FORMULA'
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
                Monitor_Tag,
                Unit_Tag;

end;

$function$;
