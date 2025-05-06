create or replace procedure camdecmpsaux.PDEM_Update_Public
(
    in vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Public';
    
    vSqlState text;
    vErrorContext text;
begin
    
    vResult := true;
    vErrorMessage := '';
    
    -- P75 Hour
    if ( vResult ) then
        call camdecmpsaux.PDEM_Update_Public_Load_P75_Unit_Hour( vPdemReportId, vResult, vErrorMessage );
    end if;
    
    -- P75 Day
    if ( vResult ) then
        call camdecmpsaux.PDEM_Update_Public_Load_P75_Unit_Day( vPdemReportId, vResult, vErrorMessage );
    end if;
    
    -- P75 Month
    if ( vResult ) then
        call camdecmpsaux.PDEM_Update_Public_Load_P75_Unit_Month( vPdemReportId, vResult, vErrorMessage );
    end if;
    
    -- P75 Quarter
    if ( vResult ) then
        call camdecmpsaux.PDEM_Update_Public_Load_P75_Unit_Quarter( vPdemReportId, vResult, vErrorMessage );
    end if;
    
    -- P75 Annual
    if ( vResult ) then
        call camdecmpsaux.PDEM_Update_Public_Load_P75_Unit_Annual( vPdemReportId, vResult, vErrorMessage );
    end if;
    
    -- P75 Ozone
    if ( vResult ) then
        call camdecmpsaux.PDEM_Update_Public_Load_P75_Unit_Ozone( vPdemReportId, vResult, vErrorMessage );
    end if;
    
    -- MATS Hour
    if ( vResult ) then
        call camdecmpsaux.PDEM_Update_Public_Load_MATS_Unit_Hour( vPdemReportId, vResult, vErrorMessage );
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
