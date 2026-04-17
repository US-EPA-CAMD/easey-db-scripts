do $$
declare
    vEvaluationIdArray  int8[]  := array[ null ]; -- Replace null with comma delimited Evaluation_Id list.
    vNote               text    := null; -- Set this note for the Set and Queue rows.
    vRec                record;
begin
    
    -- Check the setting of input values
    if ( vEvaluationIdArray is null ) or ( array_length( vEvaluationIdArray, 1 ) = 0 ) and ( array_ndims( vEvaluationIdArray ) != 1 ) then
    
        raise notice 'vEvaluationIdArray must be a single dimension array with at least one element containing a submission id.';
    
    elsif ( vNote is null ) then
    
        raise notice 'Set a Note to include in the the Set and Queue rows.';
    
    -- Submission id does not exists or is for a completed submission.
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
    
        -- Update EVALUATION_QUEUE
        update  camdecmpsaux.EVALUATION_QUEUE
           set  completed_time = null,
                note = vNote,
                note = current_timestamp,
                status_cd = 'ERROR'
         where  evaluation_id = any( vEvaluationIdArray );
        
        -- Commit Changes
        commit;
        
    end if;
    
exception when others then
    rollback;
    raise;
end $$;
