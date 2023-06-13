-- ORIS 54832, Unit 1 for 2014 Q3
CALL camdecmpswks.revert_to_official_record('MDC-35E6818FEEB4418BA9C89E5F3BD6FE91');


-- ORIS 58054, Unit ST01 for 2021 Q4
CALL camdecmpswks.revert_to_official_record('JFDOWNSW7C-986E198D8A0B4B59A4904BEBCE02392A');

update camdecmpswks.monitor_default set end_date = '9/30/2021', end_hour = 23 where mondef_id = 'JFDOWNSW7C-C6F7A7A9C3B44AE6BA59C8204E74CD3B';
update camdecmpswks.monitor_default set end_date = '9/30/2021', end_hour = 23 where mondef_id = 'JFDOWNSW7C-33963B04689143D0B7587A15E248FCD7';


-- ORIS 880093, Unit 10D for 2021 Q3
CALL camdecmpswks.revert_to_official_record('HWLTJDVZQN-57F3AEF341144704A74DF0A80B266A2B');
