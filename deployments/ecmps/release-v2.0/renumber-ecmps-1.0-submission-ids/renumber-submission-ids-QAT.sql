----------------------------------
-- TEST_SUMMASRY (QA_SUPP_DATA) --
----------------------------------

update  camdecmps.QA_SUPP_DATA qsd
   set  submission_id = sbm.new_submission_id
  from  camdecmpsaux.SUBMISSION_MIGRATION sbm
 where  qsd.submission_id > 0
   and  sbm.old_submission_id = qsd.submission_id
   and  exists
        (
            select  1
              from  camdecmpsaux.SUBMISSION_QUEUE sbq
             where  sbq.submission_id = sbm.new_submission_id
        );

commit;
