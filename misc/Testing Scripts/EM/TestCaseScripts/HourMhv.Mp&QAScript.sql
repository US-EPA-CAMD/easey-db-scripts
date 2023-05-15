-- ORIS 628, Unit 4 for 2021 Q3
CALL camdecmpswks.revert_to_official_record('MDC-EF58D953BC3C47499A065DD0696650E1');

update camdecmpswks.monitor_span set end_date = '6/30/2021', end_hour = 23 where span_id = 'PEL-L3G357-F4FC55CEB5F847CA8E1070D402800BEE';


-- ORIS 3405, Unit JCC1 for 2021 Q4
CALL camdecmpswks.revert_to_official_record('22BXS71-B4CAFD49D0804283AD01FE0A9A9F7613');

update camdecmpswks.monitor_span set end_date = '9/30/2021', end_hour = 23 where span_id = '22BXS71-67E088AA639C479E809462A910C996EB';


-- ORIS 58054, Unit ST01 for 2021 Q4
CALL camdecmpswks.revert_to_official_record('JFDOWNSW7C-986E198D8A0B4B59A4904BEBCE02392A');

update camdecmpswks.monitor_default set end_date = '9/30/2021', end_hour = 23 where mondef_id = 'WMONTAGW10-94E197AE16264B7AA0EDE8E70E8FA522';
update camdecmpswks.test_summary set test_result_cd = 'PASSAPS' where test_sum_id = 'WRMSUPPORT-4632E7B343A64B139E0DE098162CD0BB';
update camdecmpswks.qa_supp_data set submission_availability_cd = 'GRANTED' where qa_supp_data_id = 'WRMSUPPORT-03AAA2EE2F664A018D8F8302FAB5725D';
