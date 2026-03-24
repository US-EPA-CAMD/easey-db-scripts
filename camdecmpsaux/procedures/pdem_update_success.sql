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
    
    vMonPlanId character varying;
    vRptPeriodId numeric;
    
    vSqlState text;
    vErrorContext text;
begin
    
    vResult := true;
    vErrorMessage := '';
    
    -- Mark PDEM Report processing completed.
    update  camdecmpsaux.PDEM_REPORT
       set  Apportionment_Type_Cd = vApportionmentTypeCd,
            Completed_Time = current_timestamp,
            Note = null,
            Note_Time = null
     where  Pdem_Report_Id = vPdemReportId;
    
    -- Create or replace the DM Emissions row for the emission report.
    select  rpt.Mon_Plan_Id,
            rpt.Rpt_Period_Id
      into  vMonPlanId,
            vRptPeriodId
      from  camdecmpsaux.PDEM_REPORT rpt
     where  rpt.Pdem_Report_Id = vPdemReportId;

    delete
      from  camdecmps.DM_EMISSIONS dme
     where  mon_plan_id = vMonPlanId
       AND  rpt_period_id = vRptPeriodId;
    
    insert
      into  camdecmps.DM_EMISSIONS
            (
                dm_emissions_id,
                mon_plan_id,
                rpt_period_id,
                apportionment_type_cd,
                emissions_created_flg,
                data_source,
                fac_id,
                userid,
                add_date
            )
    select  gen_random_uuid() as dm_emissions_id,
            rpt.mon_plan_id,
            rpt.rpt_period_id,
            rpt.apportionment_type_cd,
            'Y' as emissions_created_flg,
            'PDEM' as data_source,
            pln.fac_id,
            sbs.user_id as userid,
            current_timestamp as add_date
      from  camdecmpsaux.PDEM_REPORT rpt
            join camdecmps.MONITOR_PLAN pln using ( mon_plan_id )
            join camdecmpsaux.SUBMISSION_QUEUE sbq on sbq.submission_id = rpt.submission_id
            join camdecmpsaux.SUBMISSION_SET sbs using ( submission_set_id )
     where  rpt.Pdem_Report_Id = vPdemReportId;
    
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
