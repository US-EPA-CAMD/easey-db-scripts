-- To set the time columns in evaluation_queue and submission_queue for records that had null values for both completed and note time.

update camdecmpsaux.evaluation_queue
set started_time = queued_time,
    completed_time = case when status_cd = 'COMPLETE' then queued_time else null end,
    note_time = case when status_cd = 'ERROR' then queued_time else null end
where completed_time is null and note_time is null;
 
 
update camdecmpsaux.submission_queue
set started_time = queued_time,
    completed_time = case when status_cd = 'COMPLETE' then queued_time else null end,
    note_time = case when status_cd = 'ERROR' then queued_time else null end
where completed_time is null and note_time is null;