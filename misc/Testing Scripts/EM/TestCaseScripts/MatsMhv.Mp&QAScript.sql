-- ORIS 628, Unit 4 for 2021 Q3
CALL camdecmpswks.revert_to_official_record('MDC-EF58D953BC3C47499A065DD0696650E1');

-- ORIS 1710, Unit 3 for 2021 Q3
CALL camdecmpswks.revert_to_official_record('PC56436-1FA51E42A6BD4E028D4AE2C996EB15B4');
update camdecmpswks.monitor_span set end_date = '9/30/2021', end_hour = 22 where span_id = 'PC56436-CD2CF59BDFAD40A3B415CCB4529CBDD3';
