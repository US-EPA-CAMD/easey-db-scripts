-------------------
-- QA_CERT_EVENT --
-------------------

update  camdecmps.QA_CERT_EVENT qce
   set  submission_id = sbm.new_submission_id
  from  camdecmpsaux.SUBMISSION_MIGRATION sbm
 where  qce.submission_id > 0
   and  sbm.old_submission_id = qce.submission_id
   and  exists
        (
            select  1
              from  camdecmpsaux.SUBMISSION_QUEUE sbq
             where  sbq.submission_id = sbm.new_submission_id
        );

commit;
