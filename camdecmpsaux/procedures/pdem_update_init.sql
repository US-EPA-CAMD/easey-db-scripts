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
begin

    call camdecmpsaux.PDEM_Update_Init_Reset( vMonPlanId, vRptPeriodId, vSubmissionId, vPdemReportId, vResult, vErrorMessage );
	
	if vResult then
	
		CALL camdecmpsaux.PDEM_Update_Init_Load_P75_Monitor_Hour( vPdemReportId, vResult, vErrorMessage );
	
	end if;
	
	if vResult then
	
		CALL camdecmpsaux.PDEM_Update_Init_Load_Mats_Monitor_Hour( vPdemReportId, vResult, vErrorMessage );
	
	end if;
    
exception

    when others then

        vErrorMessage := IsNULL(Error_Procedure(),'DmEm.UpdateFailure') + ': ' + ERROR_MESSAGE() + ' (' + cast(Error_Line() as varchar) + ')';
        vResult := 'F';
    
end;

$procedure$;
