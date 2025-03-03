create or replace procedure camdecmpsaux.PDEM_Update_Success_Load_Unit_Day 
(
    in vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Success_Load_Unit_Day';
    
    vSqlState text;
    vErrorContext text;
begin
    
    insert
      into  camdecmpsaux.PDEM_P75_UNIT_DAY 
            (
                Unit_Id,
                Pdem_Report_Id,
                Op_Date,
                Op_Hours,
                Op_Time,
                Gload,
                Sload,
                Tload,
                Hit,
                So2m,
                So2r_Sum,
                So2r_Count,
                Co2m,
                Co2r_Sum,
                Co2r_Count,
                Noxm,
                Noxr_Sum,
                Noxr_Count,
                Mon_Plan_Id,
                Rpt_Period_Id,
                Op_Year,
                Op_Month
            )
    select  uhr.Unit_Id,
            uhr.Pdem_Report_Id,
            uhr.Op_Date,
            sum( case when uhr.Op_Time > 0 then 1 else 0 end ) as Op_Hours,
            sum( uhr.Op_Time) as Op_Time,
            sum( uhr.Gload * uhr.Op_Time ) as Gload,
            sum( uhr.Sload * uhr.Op_Time ) as Sload,
            sum( uhr.Tload * uhr.Op_Time ) as Tload,
            sum( uhr.Hit ) as Hit,
            sum( uhr.So2m ) as So2m,
            sum( uhr.So2r ) as So2r_Sum,
            sum( case when uhr.So2r is not null then 1 else 0 end ) as So2r_Count,
            sum( uhr.Co2m ) as Co2m,
            sum( uhr.Co2r ) as Co2r_Sum,
            sum( case when uhr.Co2r is not null then 1 else 0 end ) as Co2r_Count,
            sum( uhr.Noxm ) as Noxm,
            sum( uhr.Noxr ) as Noxr_Sum,
            sum( case when uhr.Noxr is not null then 1 else 0 end ) as Noxr_Count,
            uhr.Mon_Plan_Id,
            uhr.Rpt_Period_Id,
            uhr.Op_Year,
            date_part( 'month', uhr.Op_Date ) as Op_Month
      from  camdecmpsaux.PDEM_P75_UNIT_HOUR uhr
     where  uhr.Pdem_Report_Id = vPdemReportId
     group
        by  uhr.Unit_Id, 
            uhr.Pdem_Report_Id,
            uhr.Op_Date,
            uhr.Mon_Plan_Id,
            uhr.Rpt_Period_Id,
            uhr.Op_Year;
    
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
