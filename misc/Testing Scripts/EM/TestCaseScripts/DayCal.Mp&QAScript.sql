-- ORIS 3, 4 for 2021 Q3
CALL camdecmpswks.revert_to_official_record('TWCORNEL5-F4E3DAADF24B4E1C8F2BEDD2DE59B436');


-- ORIS 3, 6A for 2021 Q3
CALL camdecmpswks.revert_to_official_record('MDC-68FF9CD5F0C2464E85FD2A3C15D5A670');

update camdecmpswks.monitor_span set end_date = '9/17/2021', end_hour = 5 where span_id = 'CAMD-185B390DE00F4F898B886866158DDA5D';