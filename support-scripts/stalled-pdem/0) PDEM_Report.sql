select  rpt.status_cd,
        rpt.pdem_report_id,
        pln.oris_code,
        pln.facility_name,
        pln.locations,
        prd.period_abbreviation as quarter,
        exists( select 1 from camdecmps.EMISSION_EVALUATION where submission_id = rpt.submission_id ) as submitted_exists,
        rpt.queued_time,
        rpt.triggered_time,
        rpt.started_time,
        rpt.completed_time,
        rpt.note,
        rpt.note_time,
        rpt.submission_id
        --, rpt.*
  from  camdecmpsaux.PDEM_REPORT rpt
        join camdecmpsmd.REPORTING_PERIOD prd using ( rpt_period_id )
        join camdecmps.VW_MONITOR_PLAN pln using ( mon_plan_id )
 where  rpt.completed_time is null
 order
    by  case (rpt.status_cd) when 'QUEUED' then 8 when 'COMPLETE' then 9 when 'WIP' then 1 else 0 end,
        case (rpt.status_cd) when 'QUEUED' then rpt.pdem_report_id else 0 end,
        pln.oris_code,
        pln.facility_name,
        pln.locations,
        prd.period_abbreviation
;
