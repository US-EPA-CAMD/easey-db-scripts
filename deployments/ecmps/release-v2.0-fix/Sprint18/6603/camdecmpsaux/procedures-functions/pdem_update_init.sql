create or replace procedure camdecmpsaux.PDEM_Update_Init
(
    in  vPdemReportId bigint,
    out vMonPlanId varchar,
    out vRptPeriodId numeric,
    out vIsMatsEmissionReport boolean, 
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Init';
    
    vSqlState text;
    vErrorContext text;
begin

    -- Get Output Parameters
    select  rpt.Mon_Plan_Id,
            rpt.Rpt_Period_Id
      into  vMonPlanId,
            vRptPeriodId
      from  camdecmpsaux.PDEM_REPORT rpt
     where  rpt.Pdem_Report_Id = vPdemReportId;
    
    vIsMatsEmissionReport := camdecmpsaux.PDEM_Is_Mats_Emission_Report( vMonPlanId, vRptPeriodId );
    
    
    -- Initialize Data
    call camdecmpsaux.PDEM_Update_Init_Reset( vPdemReportId, vResult, vErrorMessage );
	
	if vResult then
	
		CALL camdecmpsaux.PDEM_Update_Init_Load_P75_Monitor_Hour( vPdemReportId, vResult, vErrorMessage );
	
	end if;
	
	if vResult then
	
		CALL camdecmpsaux.PDEM_Update_Init_Load_Mats_Monitor_Hour( vPdemReportId, vResult, vErrorMessage );
	
	end if;
    
exception when others then
    
    get stacked diagnostics 
        vSqlState := returned_sqlstate,
        vErrorMessage := message_text,
        vErrorContext := pg_exception_context;
    
    raise notice 'SQL State: %', vSqlState;
    raise notice 'Error Message: %', vErrorMessage;
    raise notice 'Error Context: %', vErrorContext;
    
    vResult := 'F';
    vErrorMessage := concat( cRoutineName, ': ', vErrorMessage );
    
end;

$procedure$;
