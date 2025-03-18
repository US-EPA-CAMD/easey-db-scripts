create or replace procedure camdecmpsaux.PDEM_Update_Public_Load_P75_Unit_Day 
(
    in vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Public_Load_Unit_Day';
    
    vArchived boolean;
    vDataSource varchar(35) := 'PDEM Load Process';
    vQuarterBeginDate date;
    vQuarterEndDate date;
    vUnitIds numeric(38)[];
    vUserid varchar(160);
    
    vSqlState text;
    vErrorContext text;
begin
    
    -- Get PDEM Report Specific Information.
    select  ( oyr.Archive_Ind = 1 )::boolean as Archived,
            prd.Begin_Date,
            prd.End_Date,
            sbs.User_Id
      into  vArchived,
            vQuarterBeginDate,
            vQuarterEndDate,
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
          from  camddmw.DAY_UNIT_DATA
         where  Op_Date between vQuarterBeginDate and vQuarterEndDate
           and  Unit_Id = any( vUnitIds );
    
        insert
          into  camddmw.DAY_UNIT_DATA 
                (
                    Unit_Id,
                    Op_Date,
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
                    Rpt_Period_Id,
                    Op_Year,
                    Op_Month,
                    Data_Source,
                    Userid,
                    Add_Date
                )
        select  dat.Unit_Id,
                dat.Op_Date,
                sum( case when dat.Op_Time > 0 then 1 else 0 end ) as Op_Hours,
                sum( dat.Op_Time ) as Op_Time,
                sum( dat.Gload * dat.Op_Time ) as Gload,
                sum( dat.Sload * dat.Op_Time ) as Sload,
                sum( dat.Tload * dat.Op_Time ) as Tload,
                sum( dat.Heat_Input ) as Heat_Input,
                -- SO2
                case
                    when sum( dat.So2_Mass ) is null then null
                    else round( sum( dat.So2_Mass ) / 2000, 3)
                end as So2_Mass_Tons,
                sum( dat.So2_Mass ) as So2_Mass_Lbs,
                case
                    when sum( dat.So2_Rate ) is null then null
                    when sum( case when dat.So2_Rate is not null then 1 else 0 end ) = 0 then null
                    else round( sum( dat.So2_Rate ) / sum( case when dat.So2_Rate is not null then 1 else 0 end ), 4 )
                end as So2_Rate,
                sum( dat.So2_Rate ) as So2_Rate_Sum,
                sum( case when dat.So2_Rate is not null then 1 else 0 end ) as So2r_Count,
                -- CO2
                sum( dat.Co2_Mass ) as Co2_Mass,
                case
                    when sum( dat.Co2_Rate ) is null then null
                    when sum( case when dat.Co2_Rate is not null then 1 else 0 end ) = 0 then null
                    else round( sum( dat.Co2_Rate ) / sum( case when dat.Co2_Rate is not null then 1 else 0 end ), 4 )
                end as Co2_Rate,
                sum( dat.Co2_Rate ) as Co2r_Sum,
                sum( case when dat.Co2_Rate is not null then 1 else 0 end ) as Co2r_Count,
                -- NOx
                case
                    when sum( dat.Nox_Mass ) is null then null
                    else round( sum( dat.Nox_Mass ) / 2000, 3)
                end as Nox_Mass_Tons,
                sum( dat.Nox_Mass  ) as Nox_Mass_Lbs,
                case
                    when sum( dat.Nox_Rate ) is null then null
                    when sum( case when dat.Nox_Rate is not null then 1 else 0 end ) = 0 then null
                    else round( sum( dat.Nox_Rate ) / sum( case when dat.Nox_Rate is not null then 1 else 0 end ), 4 )
                end as Nox_Rate,
                sum( dat.Nox_Rate ) as Noxr_Sum,
                sum( case when dat.Nox_Rate is not null then 1 else 0 end ) as Noxr_Count,
                -- Other
                dat.Rpt_Period_Id,
                dat.Op_Year,
                date_part( 'month', dat.Op_Date ) as Op_Month,
                vDataSource as Data_Source,
                vUserid as Userid,
                current_timestamp as Add_Date
          from  camddmw.HOUR_UNIT_DATA dat
         where  dat.Op_Date between vQuarterBeginDate and vQuarterEndDate
           and  dat.Unit_Id = any( vUnitIds )
         group
            by  dat.Unit_Id, 
                dat.Op_Date,
                dat.Rpt_Period_Id,
                dat.Op_Year;
        
    else
        
        delete
          from  camddmw_arch.DAY_UNIT_DATA_A
         where  Op_Date between vQuarterBeginDate and vQuarterEndDate
           and  Unit_Id = any( vUnitIds );
    
        insert
          into  camddmw_arch.DAY_UNIT_DATA_A 
                (
                    Unit_Id,
                    Op_Date,
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
                    Rpt_Period_Id,
                    Op_Year,
                    Op_Month,
                    Data_Source,
                    Userid,
                    Add_Date
                )
        select  dat.Unit_Id,
                dat.Op_Date,
                sum( case when dat.Op_Time > 0 then 1 else 0 end ) as Op_Hours,
                sum( dat.Op_Time ) as Op_Time,
                sum( dat.Gload * dat.Op_Time ) as Gload,
                sum( dat.Sload * dat.Op_Time ) as Sload,
                sum( dat.Tload * dat.Op_Time ) as Tload,
                sum( dat.Heat_Input ) as Heat_Input,
                -- SO2
                case
                    when sum( dat.So2_Mass ) is null then null
                    else round( sum( dat.So2_Mass ) / 2000, 3)
                end as So2_Mass_Tons,
                sum( dat.So2_Mass ) as So2_Mass_Lbs,
                case
                    when sum( dat.So2_Rate ) is null then null
                    when sum( case when dat.So2_Rate is not null then 1 else 0 end ) = 0 then null
                    else round( sum( dat.So2_Rate ) / sum( case when dat.So2_Rate is not null then 1 else 0 end ), 4 )
                end as So2_Rate,
                sum( dat.So2_Rate ) as So2_Rate_Sum,
                sum( case when dat.So2_Rate is not null then 1 else 0 end ) as So2r_Count,
                -- CO2
                sum( dat.Co2_Mass ) as Co2_Mass,
                case
                    when sum( dat.Co2_Rate ) is null then null
                    when sum( case when dat.Co2_Rate is not null then 1 else 0 end ) = 0 then null
                    else round( sum( dat.Co2_Rate ) / sum( case when dat.Co2_Rate is not null then 1 else 0 end ), 4 )
                end as Co2_Rate,
                sum( dat.Co2_Rate ) as Co2r_Sum,
                sum( case when dat.Co2_Rate is not null then 1 else 0 end ) as Co2r_Count,
                -- NOx
                case
                    when sum( dat.Nox_Mass ) is null then null
                    else round( sum( dat.Nox_Mass ) / 2000, 3)
                end as Nox_Mass_Tons,
                sum( dat.Nox_Mass  ) as Nox_Mass_Lbs,
                case
                    when sum( dat.Nox_Rate ) is null then null
                    when sum( case when dat.Nox_Rate is not null then 1 else 0 end ) = 0 then null
                    else round( sum( dat.Nox_Rate ) / sum( case when dat.Nox_Rate is not null then 1 else 0 end ), 4 )
                end as Nox_Rate,
                sum( dat.Nox_Rate ) as Noxr_Sum,
                sum( case when dat.Nox_Rate is not null then 1 else 0 end ) as Noxr_Count,
                -- Other
                dat.Rpt_Period_Id,
                dat.Op_Year,
                date_part( 'month', dat.Op_Date ) as Op_Month,
                vDataSource as Data_Source,
                vUserid as Userid,
                current_timestamp as Add_Date
          from  camddmw_arch.HOUR_UNIT_DATA_A dat
         where  dat.Op_Date between vQuarterBeginDate and vQuarterEndDate
           and  dat.Unit_Id = any( vUnitIds )
         group
            by  dat.Unit_Id, 
                dat.Op_Date,
                dat.Rpt_Period_Id,
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
