/*
    The purpose of this ticket is to end the listed evaluation ids as errored.
    
    The runner of this script should do the following:
    
    1) Ensure that the listed Evaluation Ids are actually stalled.  More recent ids that are listed in the Identify Stalled Evaluations script may not actually be stalled.
    2) Updated the vEvaluationIdArray array values with the list of Evaluation Ids.  The Check Evaluation Id List will help ensure that the list is correct.
    3) Provide an error note in the vNote variable.  It is required for the script to run.
*/
do $$
declare
    vEvaluationIdArray  int8[]  := array[ null ]; -- Replace null with comma delimited Evaluation_Id list.
    vNote               text    := null; -- Set this note for the Set and Queue rows.
    vRec                record;
begin
    
    -- Check the setting of input values
    if ( vEvaluationIdArray is null ) or ( array_length( vEvaluationIdArray, 1 ) = 0 ) and ( array_ndims( vEvaluationIdArray ) != 1 ) then
    
        raise notice 'vEvaluationIdArray must be a single dimension array with at least one element containing a evaluation id.';
    
    elsif ( vNote is null ) then
    
        raise notice 'Set a Note to include in the the Set and Queue rows.';
    
    -- Evaluation id does not exists or is for a completed evaluation.
    elsif exists
          (
            select  eva.evaluation_id
              from  unnest( vEvaluationIdArray ) as eva( evaluation_id )
             where  not exists
                    (
                        select  1
                          from  camdecmpsaux.EVALUATION_QUEUE evq
                         where  evq.evaluation_id = eva.evaluation_id
                           and  evq.status_cd != 'COMPLETE'
                    )
          )
    then
    
        for vRec in 
        (
            select  eva.evaluation_id,
                    evq.status_cd
              from  unnest( vEvaluationIdArray ) as eva( evaluation_id )
                    left join camdecmpsaux.EVALUATION_QUEUE evq using ( evaluation_id )
        )
        loop
            
            if ( vRec.status_cd is null ) then
                raise notice 'Evaluation id "%" does not exist in EVALUATION_QUEUE.', vRec.evaluation_id;
            elsif ( vRec.status_cd = 'COMPLETE' ) then
                raise notice 'Evaluation id "%" has a Complete status.', vRec.evaluation_id;
            end if;
            
        end loop;
        
        raise notice 'NO UPDATES OCCURRED';
        
    else
    
        raise notice 'Update Starting';

        -- Update EVALUATION_QUEUE
        update  camdecmpsaux.EVALUATION_QUEUE
           set  completed_time = null,
                note = vNote,
                note_time = current_timestamp,
                status_cd = 'ERROR'
         where  evaluation_id = any( vEvaluationIdArray );
        
        -- Commit Changes
        --commit;
        
        raise notice 'Update Completed';
    end if;
    
exception when others then
    --rollback;
    raise;
end $$;
