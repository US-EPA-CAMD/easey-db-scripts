create or replace procedure camdecmpsaux.PDEM_Update_Failure 
(
    in vPdemReportId bigint,
    in vApportionmentTypeCd varchar,
    out vResult char, 
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
            Emissions_Created_Flg = 'N'
     where  Pdem_Report_Id = vPdemReportId;
    
    vResult := 'T';
    vErrorMessage := '';

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
