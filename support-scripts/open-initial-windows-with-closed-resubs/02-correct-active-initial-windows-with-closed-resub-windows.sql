
-- Store Initial-Resub Pairs to Handle
create temp table INITIAL_RESUB_WINDOW_PAIR as
    select  int.em_sub_access_id as initial_window_id,
            res.em_sub_access_id as resub_window_id,
            res.em_status_cd,
            res.sub_availability_cd,
            res.submission_id
      from  camdecmpsaux.EM_SUBMISSION_ACCESS int
            join camdecmpsaux.EM_SUBMISSION_ACCESS res using ( mon_plan_id, rpt_period_id )
     where  -- Initial vs Resub Checks
            res.access_begin_date >= int.access_begin_date
       and  res.access_end_date <= int.access_end_date
       and  res.em_sub_access_id != int.em_sub_access_id
            -- Initial Value Conditions
       and  int.em_sub_type_cd = 'INITIAL'
       and  coalesce( int.em_status_cd, '' ) = 'APPRVD'
       and  coalesce( int.sub_availability_cd, '' ) = 'REQUIRE'
       and  int.submission_id is null
            -- Resub Value Conditions
       and  res.em_sub_type_cd = 'RQRESUB'
       and  coalesce( res.em_status_cd, '' ) = 'RECVD'
       and  coalesce( res.sub_availability_cd, '' ) = 'UPDATED'
       and  coalesce( res.submission_id, 0 ) > 0;

-- Update the Initial Windows
update  camdecmpsaux.EM_SUBMISSION_ACCESS int
   set  em_status_cd = lst.em_status_cd,
        sub_availability_cd = lst.sub_availability_cd,
        submission_id = lst.submission_id,
        userid = ( '#7312 for ESA Id ' || lst.resub_window_id ),
        update_date = now()
  from  INITIAL_RESUB_WINDOW_PAIR lst
 where  int.em_sub_access_id = lst.initial_window_id;

-- Move Emails to Process from Resub to Initial
update  camdecmpsaux.EMAIL_TO_PROCESS etp
   set  em_sub_access_id = lst.initial_window_id
  from  INITIAL_RESUB_WINDOW_PAIR lst
 where  etp.em_sub_access_id = lst.resub_window_id;

-- Delete the Resub Windows
delete
  from  camdecmpsaux.EM_SUBMISSION_ACCESS esa
 using  INITIAL_RESUB_WINDOW_PAIR lst
 where  esa.em_sub_access_id = lst.resub_window_id;
  

commit;
