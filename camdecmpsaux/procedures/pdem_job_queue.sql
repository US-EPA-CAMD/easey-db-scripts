create or replace procedure camdecmpsaux.PDEM_Job_Queue
(
    in  vMonPlanId varchar,
    in  vRptPeriodId numeric,
    in  vSubmissionId bigint
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Job_Queue';
    
    vPdemReportId bigint;
    
    vSqlState text;
    vErrorContext text;
begin

    -- Update unlocked version if it exists.
    update  camdecmpsaux.PDEM_Report
       set  submission_id = vSubmissionId,
            queued_time = current_timestamp
     where  Pdem_Report_Id in
            (
                select  rpt.Pdem_Report_Id
                  from  camdecmpsaux.PDEM_Report rpt
                 where  rpt.mon_plan_id = vMonPlanId
                   and  rpt.rpt_period_id = vRptPeriodId
                   and  rpt.triggered_time is null
                 order
                    by  rpt.queued_time desc
                 limit  1
                 for    update skip locked
            )
    returning   pdem_report_id
         into   vPdemReportId;
    
    -- Insert new version if unlocked version does not exist.
    if ( vPdemReportId is null ) then
    
        insert
          into  camdecmpsaux.PDEM_Report
                (
                    mon_plan_id,
                    rpt_period_id,
                    submission_id
                )
        values  (
                    vMonPlanId,
                    vRptPeriodId,
                    vSubmissionId
                );
    
    end if;
    
end;

$procedure$;
