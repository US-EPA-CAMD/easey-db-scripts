create or replace procedure camdecmpsaux.PDEM_Update_Init_Reset 
(
    in  vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Init_Reset';

    
    vSqlState text;
    vErrorContext text;
begin
    
    -- Delete from PDEM_MATS_MONITOR_HOUR for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_MATS_MONITOR_HOUR 
     where  Pdem_Report_Id = vPdemReportId;
    
    -- Delete from PDEM_MATS_UNIT_HOUR for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_MATS_UNIT_HOUR 
     where  Pdem_Report_Id = vPdemReportId;
    
    -- Delete from PDEM_P75_MONITOR_HOUR for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_MONITOR_HOUR 
     where  Pdem_Report_Id = vPdemReportId;

    -- Delete from PDEM_P75_UNIT_QUARTER for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_UNIT_QUARTER 
     where  Pdem_Report_Id = vPdemReportId;
    
    -- Delete from PDEM_P75_UNIT_MONTH for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_UNIT_MONTH 
     where  Pdem_Report_Id = vPdemReportId;
    
    -- Delete from PDEM_P75_UNIT_DAY for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_UNIT_DAY 
     where  Pdem_Report_Id = vPdemReportId;
    
    -- Delete from PDEM_P75_UNIT_HOUR for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_UNIT_HOUR 
     where  Pdem_Report_Id = vPdemReportId;
    
    -- Delete from PDEM_REPORT_USER for PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_REPORT_USER 
     where  Pdem_Report_Id = vPdemReportId;
    
    -- Reset PDEM_REPORT columns
    update  camdecmpsaux.PDEM_REPORT
       set  Started_Time = current_timestamp,
            Completed_Time = null,
            Note = null,
            Note_Time = null
     where  Pdem_Report_Id = vPdemReportId;
    
    
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
    
    vPdemReportId := null;
    vResult := false;
    vErrorMessage := concat( cRoutineName, ': ', vErrorMessage );
    
end;

$procedure$;
