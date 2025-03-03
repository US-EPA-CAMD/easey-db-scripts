create or replace procedure camdecmpsaux.PDEM_Update_Success 
(
    in vPdemReportId bigint,
    in vApportionmentTypeCd varchar,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Success';
    
    vSqlState text;
    vErrorContext text;
begin
    
    vResult := true;
    vErrorMessage := '';
    
    if vResult then
        call camdecmpsaux.PDEM_Update_Success_Load_Unit_Day( vPdemReportId, vResult, vErrorMessage );
    end if;
    
    if vResult then
        call camdecmpsaux.PDEM_Update_Success_Load_Unit_Month( vPdemReportId, vResult, vErrorMessage );
    end if;
    
    if vResult then
        call camdecmpsaux.PDEM_Update_Success_Load_Unit_Quarter( vPdemReportId, vResult, vErrorMessage );
    end if;
    
    if vResult then
        update  camdecmpsaux.PDEM_REPORT
           set  Apportionment_Type_Cd = vApportionmentTypeCd,
                Completed_Time = current_timestamp,
                Note = null,
                Note_Time = null
         where  Pdem_Report_Id = vPdemReportId;
    else
        update  camdecmpsaux.PDEM_REPORT
           set  Apportionment_type_Cd = vApportionmentTypeCd,
                Completed_Time = null,
                Note = vErrorMessage,
                Note_Time = current_timestamp
     where  Pdem_Report_Id = vPdemReportId;
    end if;
    
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
