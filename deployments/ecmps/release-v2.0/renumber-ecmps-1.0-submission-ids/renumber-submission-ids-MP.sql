begin
    
    ------------------
    -- MONITOR_PLAN --
    ------------------
    
    update  camdecmps.MONITOR_PLAN pln
       set  submission_id = sbm.new_submission_id
      from  camdecmpsaux.SUBMISSION_MIGRATION sbm
     where  pln.submission_id > 0
       and  sbm.old_submission_id = pln.submission_id
       and  exists
            (
                select  1
                  from  camdecmpsaux.SUBMISSION_QUEUE sbq
                 where  sbq.submission_id = sbm.new_submission_id
            );
    
    commit;
    
end
