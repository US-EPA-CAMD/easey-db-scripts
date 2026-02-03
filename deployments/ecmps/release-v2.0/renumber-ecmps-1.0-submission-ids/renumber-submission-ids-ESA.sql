--------------------------
-- EM_SUBMISSION_ACCESS --
--------------------------

update  camdecmpsaux.EM_SUBMISSION_ACCESS esa
   set  submission_id = sam.submission_id
  from  camdecmpsaux.EM_SUBMISSION_ACCESS_MIGRATION sam
 where  ( esa.submission_id is null or esa.submission_id > 0 )
   and  sam.em_sub_access_id = esa.em_sub_access_id
   and  exists
        (
            select  1
              from  camdecmpsaux.SUBMISSION_QUEUE sbq
             where  sbq.submission_id = sam.submission_id
        );

commit;
