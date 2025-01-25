create or replace procedure camdecmpsaux.PDEM_Update_Init
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
    cRoutineName constant varchar := 'PDEM_Update_Init';
    
    vSqlState text;
    vErrorContext text;
begin

    call camdecmpsaux.PDEM_Update_Init_Reset( vMonPlanId, vRptPeriodId, vSubmissionId, vPdemReportId, vResult, vErrorMessage );
	
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
