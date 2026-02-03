------------------------------
-- TEST_EXTENSION_EXEMPTION --
------------------------------

update  camdecmps.TEST_EXTENSION_EXEMPTION tee
   set  submission_id = sbm.new_submission_id
  from  camdecmpsaux.SUBMISSION_MIGRATION sbm
 where  tee.submission_id > 0
   and  sbm.old_submission_id = tee.submission_id
   and  exists
        (
            select  1
              from  camdecmpsaux.SUBMISSION_QUEUE sbq
             where  sbq.submission_id = sbm.new_submission_id
        );

commit;
