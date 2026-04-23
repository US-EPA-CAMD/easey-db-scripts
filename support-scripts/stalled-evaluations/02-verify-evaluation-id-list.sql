/*
    The purpose of this ticket is to test the list of Evaluation Ids to ensure that they match up with actual Evaluation Id.

    Any Id without additional information is not an actual Evaluation Id.
*/
select  eva.evaluation_id,
        evq.process_cd,
        evq.status_cd,
        evq.queued_time,
        evq.started_time,
        evq.completed_time,
        evq.note,
        evq.note_time
  from  unnest( array[ null /*  Replace null with comma delimited Evaluation_Id list. */ ] ) as eva( evaluation_id )
        left join camdecmpsaux.EVALUATION_QUEUE evq using ( evaluation_id )
 order 
    by  eva.evaluation_id;
