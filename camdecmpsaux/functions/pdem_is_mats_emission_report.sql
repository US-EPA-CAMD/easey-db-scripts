create or replace function camdecmpsaux.PDEM_Is_Mats_Emission_Report
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric
)
    returns smallint

language plpgsql

as $function$

declare
    vResult smallint;
begin

    select  coalesce( max( 1 ), 0 )
      into  vResult
      from  camdecmps.EMISSION_EVALUATION ems
            join camdecmpsmd.REPORTING_PERIOD prd
              on prd.Rpt_Period_Id = ems.Rpt_Period_Id
            join camdecmps.MONITOR_PLAN_LOCATION mpl
              on mpl.Mon_Plan_Id = ems.Mon_Plan_Id
            join camdecmps.MONITOR_METHOD mth
              on mth.Mon_Loc_Id = mpl.Mon_Loc_Id
             and mth.Parameter_Cd in ( 'HGRE', 'HGRH', 'HCLRE', 'HCLRH', 'HFRE', 'HFRH' )
             and mth.Begin_Date <= prd.End_Date
             and coalesce( mth.End_Date, prd.End_Date ) >= prd.Begin_Date
     where	ems.Mon_Plan_Id = vMonPlanId
       and  ems.Rpt_Period_Id = vRptPeriodId
       and  exists
            (
                select  1 
                  from  camdecmps.MATS_DERIVED_HRLY_VALUE mdv
                 where  mdv.Mon_Loc_Id = mpl.Mon_Loc_Id
                   and  mdv.Rpt_Period_Id = prd.Rpt_Period_Id
                   and  mdv.Parameter_Cd in ( 'HGRE', 'HGRH', 'HCLRE', 'HCLRH', 'HFRE', 'HFRH' )
            );
    
    return vResult;
    
end;

$function$;
