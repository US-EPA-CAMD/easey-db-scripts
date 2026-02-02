begin
    
    -------------------------
    -- EMISSION_EVALUATION --
    -------------------------
    
    update  camdecmps.EMISSION_EVALUATION ems
       set  submission_id = sbm.new_submission_id
      from  camdecmpsaux.SUBMISSION_MIGRATION sbm
     where  ems.submission_id > 0
       and  sbm.old_submission_id = ems.submission_id
       and  exists
            (
                select  1
                  from  camdecmpsaux.SUBMISSION_QUEUE sbq
                 where  sbq.submission_id = sbm.new_submission_id
            );
    
    commit;
    
end
