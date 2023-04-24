-- ORIS 1678, Locations CP1, 1, 2 for 2021 Q4

-- ORIS 2131, Locations 4A for 2021 Q4
CALL camdecmpswks.revert_to_official_record('MDC-631B4DDAC9D240CFB3A93931FFC8184D');
update camdecmpswks.monitor_default set end_date = '09/30/2021', end_hour = 23 where mondef_id = 'C2546074-71531235A1834E00AB0E00E95C69D04A';

-- ORIS 2408, Locations 1  for 2016 Q4
CALL camdecmpswks.revert_to_official_record('MDC-5E85FFC77B904C56B26DF39F0447A288');

-- ORIS 3576, Locations BW2  for 2021 Q4
CALL camdecmpswks.revert_to_official_record('MDC-D7D6C869E87D4E4EAE2FD952C52ACA15');
update camdecmpswks.monitor_formula set equation_cd = null where mon_form_id = 'CAMD-BEB493BCA38D4860B9F98ECAEEDB76AC';
update camdecmpswks.monitor_formula set equation_cd = null where mon_form_id = 'CAMD-12B03EE98210402DA0D9EBA9E99A20B3';

-- ORIS 58054, Locations ST01  for 2021 Q4
CALL camdecmpswks.revert_to_official_record('JFDOWNSW7C-986E198D8A0B4B59A4904BEBCE02392A');
update camdecmpswks.monitor_formula set equation_cd = null where mon_form_id = 'JFDOWNSW7C-222DA672B4AC4A06BDA2378CFB875D4E';
delete from  camdecmpswks.qa_supp_data qsd where  qsd.mon_loc_id = '6800' and  qsd.test_type_cd = 'RATA' and  qsd.end_date > '6/17/2021';

-- ORIS 880093, Locations 10D  for 2021 Q3
CALL camdecmpswks.revert_to_official_record('HWLTJDVZQN-57F3AEF341144704A74DF0A80B266A2B');
update camdecmpswks.monitor_formula set equation_cd = null where mon_form_id = 'HWLTJDVZQN-A3BBC826F3E2422EB4BBC565516E7175';

commit;
