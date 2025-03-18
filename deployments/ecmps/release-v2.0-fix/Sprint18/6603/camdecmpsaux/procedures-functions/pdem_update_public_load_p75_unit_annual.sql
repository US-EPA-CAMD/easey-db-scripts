create or replace procedure camdecmpsaux.PDEM_Update_Public_Load_P75_Unit_Annual 
(
    in vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Public_Load_Unit_Annual';
    
    vArchived boolean;
    vDataSource varchar(35) := 'PDEM Load Process';
    vUnitIds numeric(38)[];
    vUserid varchar(160);
    vYear smallint;
    
    vSqlState text;
    vErrorContext text;
begin
    
    -- Get PDEM Report Specific Information.
    select  ( oyr.Archive_Ind = 1 )::boolean as Archived,
            prd.Calendar_Year,
            sbs.User_Id
      into  vArchived,
            vYear,
            vUserid
      from  camdecmpsaux.PDEM_Report rpt
            join camdecmpsmd.REPORTING_PERIOD prd using ( Rpt_Period_Id )
            join camddmw.OP_YEAR oyr on oyr.Op_Year = prd.Calendar_Year
            join camdecmpsaux.SUBMISSION_QUEUE sbq using ( Submission_Id )
            join camdecmpsaux.SUBMISSION_SET sbs using ( Submission_Set_Id )
     where  rpt.Pdem_Report_Id = vPdemReportId;   
    
    -- Get Array of Units for the PDEM Report
    select  array
            (
                select  loc.Unit_Id
                  from  camdecmpsaux.PDEM_Report rpt
                        join camdecmps.MONITOR_PLAN_LOCATION mpl using ( Mon_Plan_Id )
                        join camdecmps.MONITOR_LOCATION loc using ( Mon_Loc_Id )
                 where  rpt.Pdem_Report_Id = vPdemReportId
                   and  loc.Unit_Id is not null
            )
      into  vUnitIds;
    
    -- Update either the current or archived data.
    if ( not vArchived ) then
        
        delete
          from  camddmw.ANNUAL_UNIT_DATA
         where  Op_Year = vYear
           and  Unit_Id = any( vUnitIds );
        
        insert
          into  camddmw.ANNUAL_UNIT_DATA 
                (
                    Unit_Id,
                    Op_Year,
                    Count_Op_Time,
                    Sum_Op_Time,
                    Gload,
                    Sload,
                    Tload,
                    Heat_Input,
                    So2_Mass,
                    So2_Mass_Lbs,
                    So2_Rate,
                    So2_Rate_Sum,
                    So2_Rate_Count,
                    Co2_Mass,
                    Co2_Rate,
                    Co2_Rate_Sum,
                    Co2_Rate_Count,
                    Nox_Mass,
                    Nox_Mass_Lbs,
                    Nox_Rate,
                    Nox_Rate_Sum,
                    Nox_Rate_Count,
                    Num_Months_Reported,
                    Data_Source,
                    Userid,
                    Add_Date
                )
        select  dat.Unit_Id,
                dat.Op_Year,
                sum( dat.Count_Op_Time) as Count_Op_Time,
                sum( dat.Sum_Op_Time) as Sum_Op_Time,
                sum( dat.Gload) as Gload,
                sum( dat.Sload) as Sload,
                sum( dat.Tload) as Tload,
                sum( dat.Heat_Input ) as Heat_Input,
                sum( dat.So2_Mass ) as So2_Mass,
                sum( dat.So2_Mass_Lbs ) as So2_Mass_Lbs,
                case
                    when sum( dat.So2_Rate_Sum ) is null then null
                    when sum( dat.So2_Rate_Count ) = 0 then null
                    else round( sum( dat.So2_Rate_Sum ) / sum( dat.So2_Rate_Count ), 4 )
                end as So2_Rate,
                sum( dat.So2_Rate_Sum ) as So2_Rate_Sum,
                sum( dat.So2_Rate_Count ) as So2_Rate_Count,
                sum( dat.Co2_Mass ) as Co2_Mass,
                case
                    when sum( dat.Co2_Rate_Sum ) is null then null
                    when sum( dat.Co2_Rate_Count ) = 0 then null
                    else round( sum( dat.Co2_Rate_Sum ) / sum( dat.Co2_Rate_Count ), 4 )
                end as Co2_Rate,
                sum( dat.Co2_Rate_Sum ) as Co2_Rate_Sum,
                sum( dat.Co2_Rate_Count ) as Co2_Rate_Count,
                sum( dat.Nox_Mass ) as Nox_Mass,
                sum( dat.Nox_Mass_Lbs ) as Nox_Mass_Lbs,
                case
                    when sum( dat.Nox_Rate_Sum ) is null then null
                    when sum( dat.Nox_Rate_Count ) = 0 then null
                    else round( sum( dat.Nox_Rate_Sum ) / sum( dat.Nox_Rate_Count ), 4 )
                end as Nox_Rate,
                sum( dat.Nox_Rate_Sum ) as Nox_Rate_Sum,
                sum( dat.Nox_Rate_Count ) as Nox_Rate_Count,
                sum( Num_Months_Reported ) as Num_Months_Reported,
                vDataSource as Data_Source,
                vUserid as Userid,
                current_timestamp as Add_Date
          from  camddmw.QUARTER_UNIT_DATA dat
         where  dat.Op_Year = vYear
           and  dat.Unit_Id = any( vUnitIds )
         group
            by  dat.Unit_Id, 
                dat.Op_Year;
        
    else
        
        delete
          from  camddmw_arch.ANNUAL_UNIT_DATA_A
         where  Op_Year = vYear
           and  Unit_Id = any( vUnitIds );
        
        insert
          into  camddmw_arch.ANNUAL_UNIT_DATA_A 
                (
                    Unit_Id,
                    Op_Year,
                    Count_Op_Time,
                    Sum_Op_Time,
                    Gload,
                    Sload,
                    Tload,
                    Heat_Input,
                    So2_Mass,
                    So2_Mass_Lbs,
                    So2_Rate,
                    So2_Rate_Sum,
                    So2_Rate_Count,
                    Co2_Mass,
                    Co2_Rate,
                    Co2_Rate_Sum,
                    Co2_Rate_Count,
                    Nox_Mass,
                    Nox_Mass_Lbs,
                    Nox_Rate,
                    Nox_Rate_Sum,
                    Nox_Rate_Count,
                    Num_Months_Reported,
                    Data_Source,
                    Userid,
                    Add_Date
                )
        select  dat.Unit_Id,
                dat.Op_Year,
                sum( dat.Count_Op_Time) as Count_Op_Time,
                sum( dat.Sum_Op_Time) as Sum_Op_Time,
                sum( dat.Gload) as Gload,
                sum( dat.Sload) as Sload,
                sum( dat.Tload) as Tload,
                sum( dat.Heat_Input ) as Heat_Input,
                sum( dat.So2_Mass ) as So2_Mass,
                sum( dat.So2_Mass_Lbs ) as So2_Mass_Lbs,
                case
                    when sum( dat.So2_Rate_Sum ) is null then null
                    when sum( dat.So2_Rate_Count ) = 0 then null
                    else round( sum( dat.So2_Rate_Sum ) / sum( dat.So2_Rate_Count ), 4 )
                end as So2_Rate,
                sum( dat.So2_Rate_Sum ) as So2_Rate_Sum,
                sum( dat.So2_Rate_Count ) as So2_Rate_Count,
                sum( dat.Co2_Mass ) as Co2_Mass,
                case
                    when sum( dat.Co2_Rate_Sum ) is null then null
                    when sum( dat.Co2_Rate_Count ) = 0 then null
                    else round( sum( dat.Co2_Rate_Sum ) / sum( dat.Co2_Rate_Count ), 4 )
                end as Co2_Rate,
                sum( dat.Co2_Rate_Sum ) as Co2_Rate_Sum,
                sum( dat.Co2_Rate_Count ) as Co2_Rate_Count,
                sum( dat.Nox_Mass ) as Nox_Mass,
                sum( dat.Nox_Mass_Lbs ) as Nox_Mass_Lbs,
                case
                    when sum( dat.Nox_Rate_Sum ) is null then null
                    when sum( dat.Nox_Rate_Count ) = 0 then null
                    else round( sum( dat.Nox_Rate_Sum ) / sum( dat.Nox_Rate_Count ), 4 )
                end as Nox_Rate,
                sum( dat.Nox_Rate_Sum ) as Nox_Rate_Sum,
                sum( dat.Nox_Rate_Count ) as Nox_Rate_Count,
                sum( case when dat.Sum_Op_Time is not null then 1 else 0 end ) as Num_Months_Reported,
                vDataSource as Data_Source,
                vUserid as Userid,
                current_timestamp as Add_Date
          from  camddmw_arch.QUARTER_UNIT_DATA_A dat
         where  dat.Op_Year = vYear
           and  dat.Unit_Id = any( vUnitIds )
         group
            by  dat.Unit_Id, 
                dat.Op_Year;
        
    end if;

    vResult := true;
    vErrorMessage := '';
    
exception when others then
    
    get stacked diagnostics 
        vSqlState := returned_sqlstate,
        vErrorMessage := message_text,
        vErrorContext := pg_exception_context;
    
    raise notice 'SQL State: %', vSqlState;
    raise notice 'Error Message: %', vErrorMessage;
    raise notice 'Error Context: %', vErrorContext;
    
    vResult := false;
    vErrorMessage := concat( cRoutineName, ': ', vErrorMessage );
    
end;

$procedure$;
