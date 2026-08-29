update  camdecmpsmd.MATS_REPORT_TYPE_CODE
   set  enforce_attachment_rules = false
 where  coalesce( enforce_attachment_rules, true ) != false;

commit;
