-- ORIS 404, Unit 1 for 2021 Q1
CALL camdecmpswks.revert_to_official_record('MDC-7743327CA4FB4B8CA6C0C656ECC4E1B8');
update camdecmpswks.unit_fuel set indicator_cd = 'P' where uf_id = '315';
update camdecmpswks.unit_fuel set indicator_cd = 'S' where uf_id = '316';

-- ORIS 404, Unit 2 for 2022 Q2
CALL camdecmpswks.revert_to_official_record('MDC-FCD7105F0619452A8B8E51AC625CB649');
delete from camdecmpswks.monitor_qualification_pct mqp where mqp.mon_pct_id = 'D112008420-0257A321C7534276913A010C9891FFE7';
update camdecmpswks.monitor_plan set last_updated = null, updated_status_flg = null, needs_eval_flg = null where mon_plan_id = 'MDC-FCD7105F0619452A8B8E51AC625CB649';

-- ORIS 856, Unit 2 for 2021 Q4
CALL camdecmpswks.revert_to_official_record('CLV2UA3431-665B4D63BCFB4936893A28A7751749E6');
update camdecmpswks.qa_supp_data set submission_availability_cd = 'REQUIRE' where test_sum_id = 'G000099927-A0B30028E7E846DC8DACA90E57D80839';
insert into camdecmpswks.qa_cert_event ( qa_cert_event_id, mon_loc_id, qa_cert_event_cd, mon_sys_id, component_id, qa_cert_event_date, qa_cert_event_hour, required_test_cd, needs_eval_flg, submission_availability_cd )
                                values ( (md5(random()::text || clock_timestamp()::text)::uuid)::character varying(45), '456', '2', 'CLV2UA3431-C163CA6197B344E9A30E13DBE9EB585A', 'CLV2UA3431-D8AEC213938846C7AB5DADFE91236DF8', '10/1/2021', 0, '22', 'Y', 'REQUIRE' );
insert into camdecmpswks.test_extension_exemption ( test_extension_exemption_id, mon_loc_id, extens_exempt_cd, rpt_period_id, mon_sys_id, needs_eval_flg, submission_availability_cd )
                                           values ( (md5(random()::text || clock_timestamp()::text)::uuid)::character varying(45), '456', 'F2LEXP', 116, 'CLV2UA3431-D6DF4AF7AD444276AF590EA26BB497E0', 'Y', 'REQUIRE' );
update camdecmpsaux.em_submission_access set sub_availability_cd = 'GRANTED' where em_sub_access_id = 334536;

-- ORIS 1305, Unit GT1 for 2022 Q2
CALL camdecmpswks.revert_to_official_record('BPU094-545C837365784BE781EDECEAA08626A3');
update camdecmpswks.monitor_qualification set end_date = '12/30/2021' where mon_qual_id = 'BPU1405-DC0EB51BAD0D404F9BF856A6FD9BB84B';

-- ORIS 1678, Locations CP1, 1, 2 for 2021 Q4
CALL camdecmpswks.revert_to_official_record('DSGTRMSVR-F0FB3BF26F6143B89C80025014295D52');
update camdecmpswks.monitor_method set method_cd = 'MHHI' where mon_method_id = 'CAMD-3A3E5980F37A45F58F72ECD4D91D426C';


commit;
