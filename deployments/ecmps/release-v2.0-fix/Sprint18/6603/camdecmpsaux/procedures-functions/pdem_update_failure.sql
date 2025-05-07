create or replace procedure camdecmpsaux.PDEM_Update_Failure 
(
    in vPdemReportId bigint,
    in vApportionmentTypeCd varchar,
    in vFailureMessage text,
    out vResult boolean, 
    out vErrorMessage varchar
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Failure';
    
    vSqlState text;
    vErrorContext text;
begin

    -- Update DM emissions with apportionment type and created flag
    update  camdecmpsaux.PDEM_REPORT
       set  Apportionment_type_Cd = vApportionmentTypeCd,
            Completed_Time = null,
            Note = vFailureMessage,
            Note_Time = current_timestamp
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
    
    vResult := false;
    vErrorMessage := concat( cRoutineName, ': ', vErrorMessage );
    
end;

$procedure$;
