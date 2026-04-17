do $$
declare
    vSubmissionSetId    camdecmpsaux.SUBMISSION_SET.submission_set_id%type   := null; -- Only set one of these two variables.
    vSubmissionId       camdecmpsaux.SUBMISSION_QUEUE.submission_id%type     := null; -- Only set one of these two variables.
    
    vNote               camdecmpsaux.SUBMISSION_SET.note%type                := null; -- Set this note for the Set and Queue rows.
begin
    
    -- Check the setting of input values
    if ( vSubmissionSetId is null ) and  ( vSubmissionId is null ) then
    
        raise notice 'A value for one of and only one of vSubmissionSetId and vSubmissionId must be set.';
    
    elsif ( vSubmissionSetId is not null ) and  ( vSubmissionId is not null ) then
    
        raise notice 'A value for only one of vSubmissionSetId (%) and vSubmissionId (%) can and must be set.', vSubmissionSetId, vSubmissionId;
    
    elsif ( vSubmissionSetId is not null ) and not exists ( select 1 from camdecmpsaux.SUBMISSION_QUEUE where submission_set_id = vSubmissionSetId )  then
    
        raise notice 'Submission_Set_Id "%" does not exist in camdecmpsaux.SUBMISSION_QUEUE.', vSubmissionSetId;
    
    elsif ( vSubmissionId is not null ) and not exists ( select 1 from camdecmpsaux.SUBMISSION_QUEUE where submission_id = vSubmissionId )  then
    
        raise notice 'Submission_Id "%" does not exist in camdecmpsaux.SUBMISSION_QUEUE.', vSubmissionId;
    
    elsif ( vNote is null ) then
    
        raise notice 'Set a Note to include in the the Set and Queue rows.';
    
    -- Identify Inconsistent Submission Set and Queue Statuses
    elsif exists
          (
            select  1
              from  camdecmpsaux.SUBMISSION_SET sbs
                    join camdecmpsaux.SUBMISSION_QUEUE sbq using ( submission_set_id )
             where  (
                        sbs.submission_set_id = vSubmissionSetId
                        or
                        sbs.submission_set_id in ( select submission_set_id from camdecmpsaux.SUBMISSION_QUEUE where submission_id = vSubmissionId )
                    )
                    /*
                        Note this check for matches may change if differing Set and Queue status are constent with each other.
                        
                        1) Treat CLAIMED, PENDING and WIP as matching.
                    */
               and  case when sbs.status_cd in ( 'CLAIMED', 'PENDING', 'WIP' ) then 'WIP' else sbs.status_cd end
                    !=
                    case when sbq.status_cd in ( 'CLAIMED', 'PENDING', 'WIP' ) then 'WIP' else sbq.status_cd end
          )
    then
    
        if ( vSubmissionSetId is not null ) then
            raise notice 'The Submission Set for Submission_Set_Id "%" has SUBMISSION_SET and SUBMISSION_QUEUE statuses that are not consistent with each other.', vSubmissionSetId;
        else
            raise notice 'The Submission Set for Submission_Id "%" has SUBMISSION_SET and SUBMISSION_QUEUE statuses that are not consistent with each other.', vSubmissionId;
        end if;
    
    -- Check for Submission Set or Queue with Completed Statuses
    elsif exists
          (
            select  1
              from  camdecmpsaux.SUBMISSION_SET sbs
                    join camdecmpsaux.SUBMISSION_QUEUE sbq using ( submission_set_id )
             where  (
                        sbs.submission_set_id = vSubmissionSetId
                        or
                        sbs.submission_set_id in ( select submission_set_id from camdecmpsaux.SUBMISSION_QUEUE where submission_id = vSubmissionId )
                    )
               and  (
                        sbs.status_cd = 'COMPLETE' or sbs.completed_time is not null
                        or
                        sbq.status_cd = 'COMPLETE' or sbq.completed_time is not null
                    )
          )
    then
    
        if ( vSubmissionSetId is not null ) then
            raise notice 'At least one of the Submission Set row or Submission Queue rows for Submission_Set_Id "%" has a Completed status or tinestamp.', vSubmissionSetId;
        else
            raise notice 'At least one of the Submission Set row or Submission Queue rows for the Submission Set for Submission_Id "%" has a Completed status or tinestamp.', vSubmissionId;
        end if;
        
    else
    
        -- Update SUBMISSION_SET
        update  camdecmpsaux.SUBMISSION_SET
           set  completed_time = null,
                note = vNote,
                note_time = current_timestamp,
                status_cd = 'ERROR'
         where  (
                    submission_set_id = vSubmissionSetId
                    or
                    submission_set_id in ( select submission_set_id from camdecmpsaux.SUBMISSION_QUEUE where submission_id = vSubmissionId )
                );
    
        -- Update SUBMISSION_QUEUE
        update  camdecmpsaux.SUBMISSION_QUEUE
           set  completed_time = null,
                note = vNote,
                note_time = current_timestamp,
                status_cd = 'ERROR'
         where  (
                    submission_set_id = vSubmissionSetId
                    or
                    submission_set_id in ( select submission_set_id from camdecmpsaux.SUBMISSION_QUEUE where submission_id = vSubmissionId )
                );
        
        -- Commit Changes
        --commit;
    
        if ( vSubmissionSetId is not null ) then
            raise notice 'Submission(s) ended for Submission_Set_Id "%".', vSubmissionSetId;
        else
            raise notice 'Submission(s) ended for Submission Set for Submission_Id "%".', vSubmissionId;
        end if;
        
    end if;
    
exception when others then
    --rollback;
    raise;
end $$;
