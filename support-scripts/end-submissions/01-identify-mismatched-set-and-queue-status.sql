/*
    This script is meant to identify isntances where the SUBMISSION_SET and SUBMISSION_QUEUE STATUS_CD values are not consistent.
    
    If valid differences between a SUBMISSION_SET STATUS_CD value and the STATUS_CD values of its SUBMISSION_QUEUE children, add
    a discription to the "Allowable Different Values" list below and update the query to account for the allowable differences.
    
    
    Allowable Different Values:
    
        1) Legacy ECMPS 1.0 submissions can have a 'FAILED' Queue Status and a 'COMPLETE' Set Status.  All legacy submission
           discrepancies exist because of this difference.
*/
select  sbs.oris_code,
        sbs.fac_name as facility_name,
        sbs.configuration,
        sbs.submission_set_id,
        sbs.status_cd as set_status,
        sbq.status_cd as que_status,
        sbq.submission_id,
        sbs.queued_time as set_queued,
        sbq.queued_time as que_queued,
        sbs.started_time as set_started,
        sbq.started_time as que_started,
        sbs.completed_time as set_completed,
        sbq.completed_time as que_completed,
        sbs.note as set_note,
        sbq.note as que_note,
        sbs.note_time as set_noted,
        sbq.note_time as que_noted
  from  camdecmpsaux.SUBMISSION_SET sbs
        join camdecmpsaux.SUBMISSION_QUEUE sbq using ( submission_set_id )
 where  exists
        (
            select  1
              from  camdecmpsaux.SUBMISSION_QUEUE sbq
             where  sbq.submission_set_id = sbs.submission_set_id 
               and  sbq.status_cd != sbs.status_cd
                    -- Exclude legacty submissions from the check.
               and  sbq.submission_id > 0
        )
 order
    by  oris_code,
        configuration,
        submission_set_id,
        set_status,
        que_status
;