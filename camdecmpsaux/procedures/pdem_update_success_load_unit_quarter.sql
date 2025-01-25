create or replace procedure camdecmpsaux.PDEM_Update_Success_Load_Unit_Quarter 
(
    in vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Success_Load_Unit_Quarter';
    
    vSqlState text;
    vErrorContext text;
begin
    
    insert
      into  camdecmpsaux.PDEM_P75_UNIT_QUARTER 
            (
                Unit_Id,
                Pdem_Report_Id,
                Op_Year,
                Op_Quarter,
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
                Reported_Months,
                Mon_Plan_Id,
                Rpt_Period_Id
            )
    select  umn.Unit_Id,
            umn.Pdem_Report_Id,
            umn.Op_Year,
            umn.Op_Quarter,
            sum( umn.Op_Hours) as Op_Hours,
            sum( umn.Op_Time) as Op_Time,
            sum( umn.Gload) as Gload,
            sum( umn.Sload) as Sload,
            sum( umn.Tload) as Tload,
            sum( umn.Hit ) as Hit,
            sum( umn.So2m ) as So2m,
            sum( umn.So2r_Sum ) as So2r_Sum,
            sum( umn.So2r_Count ) as So2r_Count,
            sum( umn.Co2m ) as Co2m,
            sum( umn.Co2r_Sum ) as Co2r_Sum,
            sum( umn.Co2r_Count ) as Co2r_Count,
            sum( umn.Noxm ) as Noxm,
            sum( umn.Noxr_Sum ) as Noxr_Sum,
            sum( umn.Noxr_Count ) as Noxr_Count,
            sum( case when umn.Op_Time is not null then 1 else 0 end ) as Reported_Months,
            umn.Mon_Plan_Id,
            umn.Rpt_Period_Id
      from  camdecmpsaux.PDEM_P75_UNIT_MONTH umn
     where  umn.Pdem_Report_Id = vPdemReportId
     group
        by  umn.Unit_Id, 
            umn.Pdem_Report_Id,
            umn.Op_Year,
            umn.Op_Quarter,
            umn.Mon_Plan_Id,
            umn.Rpt_Period_Id;
    
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
