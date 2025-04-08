create or replace procedure camdecmpsaux.PDEM_Update_Public_Load_P75_Unit_Hour 
(
    in  vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Public_Load_P75_Unit_Hour';
    
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
          from  camddmw.HOUR_UNIT_DATA
         where  Op_Date between vQuarterBeginDate and vQuarterEndDate
           and  Unit_Id = any( vUnitIds );
        
        insert
          into  camddmw.HOUR_UNIT_DATA 
                (
                    Unit_Id,
                    Op_Date,
                    Op_Hour,
                    Op_Time,
                    Gload,
                    Sload,
                    Tload,
                    Heat_Input,
                    Heat_Input_Measure_Flg,
                    So2_Mass,
                    So2_Mass_Measure_Flg,
                    So2_Rate,
                    So2_Rate_Measure_Flg,
                    Co2_Mass,
                    Co2_Mass_Measure_Flg,
                    Co2_Rate,
                    Co2_Rate_Measure_Flg,
                    Nox_Mass,
                    Nox_Mass_Measure_Flg,
                    Nox_Rate,
                    Nox_Rate_Measure_Flg,
                    Rpt_Period_id,
                    Op_Year,
                    Data_Source,
                    Userid,
                    Add_Date
                )
        select  dat.Unit_Id,
                dat.Op_Date,
                dat.Op_Hour,
                dat.Op_Time,
                dat.Gload,
                dat.Sload,
                dat.Tload,
                dat.Hit as Heat_Input,
                dat.Hit_Hour_Measure_Cd as Heat_Input_Measure_Flg,
                dat.So2m as So2_Mass,
                dat.So2m_Hour_Measure_Cd as So2_Mass_Measure_Flg,
                dat.So2r as So2_Rate,
                dat.So2r_Hour_Measure_Cd as So2_Rate_Measure_Flg,
                dat.Co2m as Co2_Mass,
                dat.Co2m_Hour_Measure_Cd as Co2_Mass_Measure_Flg,
                dat.Co2r as Co2_Rate,
                dat.Co2r_Hour_Measure_Cd as Co2_Rate_Measure_Flg,
                dat.Noxm as Nox_Mass,
                dat.Noxm_Hour_Measure_Cd as Nox_Mass_Measure_Flg,
                dat.Noxr as Nox_Rate,
                dat.Noxr_Hour_Measure_Cd as Nox_Rate_Measure_Flg,
                dat.Rpt_Period_id,
                dat.Op_Year,
                vDataSource as Data_Source,
                vUserid as Userid,
                current_timestamp as Add_Date
          from  camdecmpsaux.PDEM_P75_UNIT_HOUR dat
         where  dat.Pdem_Report_Id = vPdemReportId;
        
    else
        
        delete
          from  camddmw_arch.HOUR_UNIT_DATA_A
         where  Op_Date between vQuarterBeginDate and vQuarterEndDate
           and  Unit_Id = any( vUnitIds );
        
        insert
          into  camddmw_arch.HOUR_UNIT_DATA_A 
                (
                    Unit_Id,
                    Op_Date,
                    Op_Hour,
                    Op_Time,
                    Gload,
                    Sload,
                    Tload,
                    Heat_Input,
                    Heat_Input_Measure_Flg,
                    So2_Mass,
                    So2_Mass_Measure_Flg,
                    So2_Rate,
                    So2_Rate_Measure_Flg,
                    Co2_Mass,
                    Co2_Mass_Measure_Flg,
                    Co2_Rate,
                    Co2_Rate_Measure_Flg,
                    Nox_Mass,
                    Nox_Mass_Measure_Flg,
                    Nox_Rate,
                    Nox_Rate_Measure_Flg,
                    Rpt_Period_id,
                    Op_Year,
                    Data_Source,
                    Userid,
                    Add_Date
                )
        select  dat.Unit_Id,
                dat.Op_Date,
                dat.Op_Hour,
                dat.Op_Time,
                dat.Gload,
                dat.Sload,
                dat.Tload,
                dat.Hit as Heat_Input,
                dat.Hit_Hour_Measure_Cd as Heat_Input_Measure_Flg,
                dat.So2m as So2_Mass,
                dat.So2m_Hour_Measure_Cd as So2_Mass_Measure_Flg,
                dat.So2r as So2_Rate,
                dat.So2r_Hour_Measure_Cd as So2_Rate_Measure_Flg,
                dat.Co2m as Co2_Mass,
                dat.Co2m_Hour_Measure_Cd as Co2_Mass_Measure_Flg,
                dat.Co2r as Co2_Rate,
                dat.Co2r_Hour_Measure_Cd as Co2_Rate_Measure_Flg,
                dat.Noxm as Nox_Mass,
                dat.Noxm_Hour_Measure_Cd as Nox_Mass_Measure_Flg,
                dat.Noxr as Nox_Rate,
                dat.Noxr_Hour_Measure_Cd as Nox_Rate_Measure_Flg,
                dat.Rpt_Period_id,
                dat.Op_Year,
                vDataSource as Data_Source,
                vUserid as Userid,
                current_timestamp as Add_Date
          from  camdecmpsaux.PDEM_P75_UNIT_HOUR dat
         where  dat.Pdem_Report_Id = vPdemReportId;
    
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
