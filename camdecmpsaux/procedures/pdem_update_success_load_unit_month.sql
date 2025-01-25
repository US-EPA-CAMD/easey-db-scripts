create or replace procedure camdecmpsaux.PDEM_Update_Success_Load_Unit_Month 
(
    in vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Success_Load_Unit_Month';
    
    vSqlState text;
    vErrorContext text;
begin
    
    insert
      into  camdecmpsaux.PDEM_P75_UNIT_MONTH 
            (
                Unit_Id,
                Pdem_Report_Id,
                Op_Year,
                Op_Month,
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
                Op_Quarter
            )
    select  udy.Unit_Id,
            udy.Pdem_Report_Id,
            udy.Op_Year,
            udy.Op_Month,
            sum( udy.Op_Hours) as Op_Hours,
            sum( udy.Op_Time) as Op_Time,
            sum( udy.Gload) as Gload,
            sum( udy.Sload) as Sload,
            sum( udy.Tload) as Tload,
            sum( udy.Hit ) as Hit,
            sum( udy.So2m ) as So2m,
            sum( udy.So2r_Sum ) as So2r_Sum,
            sum( udy.So2r_Count ) as So2r_Count,
            sum( udy.Co2m ) as Co2m,
            sum( udy.Co2r_Sum ) as Co2r_Sum,
            sum( udy.Co2r_Count ) as Co2r_Count,
            sum( udy.Noxm ) as Noxm,
            sum( udy.Noxr_Sum ) as Noxr_Sum,
            sum( udy.Noxr_Count ) as Noxr_Count,
            udy.Mon_Plan_Id,
            udy.Rpt_Period_Id,
            case
                when udy.Op_Month in ( 1, 2, 3 ) then 1
                when udy.Op_Month in ( 4, 5, 6 ) then 2
                when udy.Op_Month in ( 7, 8, 9 ) then 3
                when udy.Op_Month in ( 10, 11, 12 ) then 4
                else null
            end as Op_Quarter
      from  camdecmpsaux.PDEM_P75_UNIT_DAY udy
     where  udy.Pdem_Report_Id = vPdemReportId
     group
        by  udy.Unit_Id, 
            udy.Pdem_Report_Id,
            udy.Op_Year,
            udy.Op_Month,
            udy.Mon_Plan_Id,
            udy.Rpt_Period_Id;
    
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
