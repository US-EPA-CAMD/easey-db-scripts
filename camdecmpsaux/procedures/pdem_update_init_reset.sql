create or replace procedure camdecmpsaux.PDEM_Update_Init_Reset 
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric,
    in vSubmissionId bigint,
    out vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Init_Reset';

    vSubmissionId numeric( 38 );
    
    vSqlState text;
    vErrorContext text;
begin
    
    -- Delete from PDEM_P75_MONITOR_HOUR for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_MONITOR_HOUR 
     where  Mon_Plan_Id = vMonPlanId
       and  Rpt_Period_Id = vRptPeriodId
        or  Pdem_Report_Id in
            (
                select  Pdem_Report_Id 
                  from  camdecmpsaux.PDEM_REPORT 
                 where  Mon_Plan_Id = vMonPlanId
                   and  Rpt_Period_Id = vRptPeriodId
            );

    -- Delete from PDEM_P75_UNIT_QUARTER for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_UNIT_QUARTER 
     where  Mon_Plan_Id = vMonPlanId
       and  Rpt_Period_Id = vRptPeriodId
        or  Pdem_Report_Id in
            (
                select  Pdem_Report_Id 
                  from  camdecmpsaux.PDEM_REPORT 
                 where  Mon_Plan_Id = vMonPlanId
                   and  Rpt_Period_Id = vRptPeriodId
            );
    
    -- Delete from PDEM_P75_UNIT_MONTH for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_UNIT_MONTH 
     where  Mon_Plan_Id = vMonPlanId
       and  Rpt_Period_Id = vRptPeriodId
        or  Pdem_Report_Id in
            (
                select  Pdem_Report_Id 
                  from  camdecmpsaux.PDEM_REPORT 
                 where  Mon_Plan_Id = vMonPlanId
                   and  Rpt_Period_Id = vRptPeriodId
            );
    
    -- Delete from PDEM_P75_UNIT_DAY for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_UNIT_DAY 
     where  Mon_Plan_Id = vMonPlanId
       and  Rpt_Period_Id = vRptPeriodId
        or  Pdem_Report_Id in
            (
                select  Pdem_Report_Id 
                  from  camdecmpsaux.PDEM_REPORT 
                 where  Mon_Plan_Id = vMonPlanId
                   and  Rpt_Period_Id = vRptPeriodId
            );
    
    -- Delete from PDEM_P75_UNIT_HOUR for MON_PLAN_ID/RPT_PERIOD_ID or PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_P75_UNIT_HOUR 
     where  Mon_Plan_Id = vMonPlanId
       and  Rpt_Period_Id = vRptPeriodId
        or  Pdem_Report_Id in
            (
                select  Pdem_Report_Id 
                  from  camdecmpsaux.PDEM_REPORT 
                 where  Mon_Plan_Id = vMonPlanId
                   and  Rpt_Period_Id = vRptPeriodId
            );
    
    -- Delete from PDEM_REPORT_USER for PDEM_REPORT_ID matching MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_REPORT_USER 
     where  Pdem_Report_Id in
            (
                select  Pdem_Report_Id 
                  from  camdecmpsaux.PDEM_REPORT 
                 where  Mon_Plan_Id = vMonPlanId
                   and  Rpt_Period_Id = vRptPeriodId
            );
    
    -- Delete from PDEM_REPORT for MON_PLAN_ID/RPT_PERIOD_ID
    delete 
      from  camdecmpsaux.PDEM_REPORT
     where  Mon_Plan_Id = vMonPlanId
       and  Rpt_Period_Id = vRptPeriodId;


    -- Check for existing EMISSION_EVALUATION row before adding PDEM_REPORT row.
    select  max( Submission_Id )
      into  vSubmissionId
      from  camdecmps.EMISSION_EVALUATION ems
     where	ems.Mon_Plan_Id = vMonPlanId
       and  ems.Rpt_Period_Id = vRptPeriodId;

    if ( vSubmissionId is not null )
    then
        
        -- Add new PDEM_REPORT row
        insert 
          into  camdecmpsaux.PDEM_REPORT
                (
                    Mon_Plan_Id, 
                    Rpt_Period_Id,  
                    Submission_Id
                )
        values  (
                    vMonPlanId, 
                    vRptPeriodId,
                    vSubmissionId
                    
                )
        returning Pdem_Report_Id into vPdemReportId;

        vResult := true;
        vErrorMessage := '';

    else
        vPdemReportId := null;
        vResult := false;
        vErrorMessage := concat( cRoutineName, ': ', 'Emission report does not exist. (Plan: ', vMonPlanId, ', Period: ', vRptPeriodId, ')' );
    end if;

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
